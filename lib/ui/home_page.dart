import 'dart:math';

import 'package:capitals/data/data.dart';
import 'package:capitals/domain/game.dart';
import 'package:capitals/domain/items.dart';
import 'package:capitals/domain/models.dart';
import 'package:capitals/domain/store.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:provider/provider.dart';
import 'package:tcard/tcard.dart';

import 'components.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  TCardController _cardsController = TCardController();

  @override
  void initState() {
    super.initState();
    onInit();
  }

  Future<void> onInit() async {
    await context.read<Assets>().load();
    StoreProvider.of<GlobalState>(context, listen: false)
        .dispatch(OnStartGameThunk());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: StoreConnector<GlobalState, ColorPair>(
        distinct: true,
        converter: (store) => store.state.palette.colors,
        builder: (context, colors) {
          return GradientBackground(
            startColor: colors.main.withOpacity(0.3),
            endColor: colors.second.withOpacity(0.3),
            child: SafeArea(
              bottom: false,
              child: StoreConnector<GlobalState, bool>(
                distinct: true,
                converter: (store) => store.state.items.isCompleted,
                builder: (context, isCompleted) => Stack(
                  children: [
                    Align(
                      alignment: Alignment.bottomCenter,
                      child: _ItemsProgress(),
                    ),
                    Align(
                      alignment: Alignment.bottomCenter,
                      child: _ScoreProgress(),
                    ),
                    _ResultOrLoading(),
                    if (!isCompleted)
                      CenterLandscape(
                        child: LayoutBuilder(
                          builder: (
                            BuildContext context,
                            BoxConstraints constraints,
                          ) =>
                              Column(
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            mainAxisSize: MainAxisSize.max,
                            children: [
                              Padding(
                                padding:
                                    const EdgeInsets.symmetric(horizontal: 12)
                                        .copyWith(top: 12.0),
                                child: _Headers(),
                              ),
                              Padding(
                                padding: const EdgeInsets.all(12.0),
                                child: _Cards(
                                  cardsController: _cardsController,
                                  constraints: constraints,
                                ),
                              ),
                              Padding(
                                padding: EdgeInsets.all(12.0),
                                child: Controls(
                                  onAnswer: (isTrue) =>
                                      _cardsController.forward(
                                    direction: isTrue
                                        ? SwipDirection.Right
                                        : SwipDirection.Left,
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                  ],
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}

class _Cards extends StatelessWidget {
  const _Cards({
    required this.cardsController,
    required this.constraints,
    Key? key,
  }) : super(key: key);

  final TCardController cardsController;
  final BoxConstraints constraints;

  @override
  Widget build(BuildContext context) {
    return StoreConnector<GlobalState, List<GameItem>>(
      distinct: true,
      converter: (store) => store.state.items.items,
      builder: (context, items) {
        if (items.isEmpty) {
          return const SizedBox.shrink();
        }
        return TCard(
          slideSpeed: 25,
          delaySlideFor: 60,
          size: Size.square(
            min(
              constraints.biggest.width,
              constraints.biggest.height / 2,
            ),
          ),
          controller: cardsController,
          cards:
              items.map((e) => CapitalCard(key: ValueKey(e), item: e)).toList(),
          onForward: (index, info) {
            StoreProvider.of<GlobalState>(context).dispatch(OnGuessThunk(
              index,
              info.direction == SwipDirection.Right,
            ));
          },
        );
      },
    );
  }
}

class _Headers extends StatelessWidget {
  const _Headers({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return StoreConnector<GlobalState, ItemsState>(
      distinct: true,
      converter: (store) => store.state.items,
      builder: (context, state) {
        if (state.isEmpty) {
          return const SizedBox.shrink();
        }
        return Headers(
          title: 'Is it ${state.current.capital}?',
          subtitle: '${state.current.country}',
        );
      },
    );
  }
}

class _ResultOrLoading extends StatelessWidget {
  const _ResultOrLoading({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return StoreConnector<GlobalState, bool>(
        distinct: true,
        converter: (store) => store.state.items.isCompleted,
        builder: (context, isCompleted) {
          if (isCompleted) {
            return Positioned.fill(
              child: StoreConnector<GlobalState, GameState>(
                distinct: true,
                converter: (store) => store.state.game,
                builder: (context, state) => CompleteWidget(
                  score: state.score,
                  topScore: state.topScore,
                  onTap: () => StoreProvider.of<GlobalState>(context)
                      .dispatch(OnResetThunk()),
                ),
              ),
            );
          } else {
            return Center(
              child: StoreConnector<GlobalState, Color>(
                  distinct: true,
                  converter: (store) => store.state.palette.colors.second,
                  builder: (context, color) => CircularProgressIndicator(
                      valueColor: AlwaysStoppedAnimation(color))),
            );
          }
        });
  }
}

class _ScoreProgress extends StatelessWidget {
  const _ScoreProgress({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return StoreConnector<GlobalState, _ColoredProgressModel>(
      distinct: true,
      converter: (store) => _ColoredProgressModel(
          store.state.game.progress, store.state.palette.colors.main),
      builder: (context, model) => ProgressWave(
        color: model.color.withOpacity(0.6),
        progress: model.progress,
        duration: Duration(seconds: 15),
      ),
    );
  }
}

class _ItemsProgress extends StatelessWidget {
  const _ItemsProgress({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return StoreConnector<GlobalState, _ColoredProgressModel>(
      distinct: true,
      converter: (store) => _ColoredProgressModel(
          store.state.items.progress, store.state.palette.colors.second),
      builder: (context, model) => ProgressWave(
        color: model.color.withOpacity(0.6),
        progress: model.progress,
        duration: Duration(seconds: 15),
      ),
    );
  }
}

class _ColoredProgressModel {
  final double progress;
  final Color color;

  const _ColoredProgressModel(this.progress, this.color);

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is _ColoredProgressModel &&
          runtimeType == other.runtimeType &&
          progress == other.progress &&
          color == other.color;

  @override
  int get hashCode => progress.hashCode ^ color.hashCode;
}
