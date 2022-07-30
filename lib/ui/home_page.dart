import 'dart:math';

import 'package:capitals/data/data.dart';
import 'package:capitals/domain/game.dart';
import 'package:capitals/domain/items.dart';
import 'package:capitals/domain/models.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:provider/provider.dart';
import 'package:tcard/tcard.dart';

import 'components.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  HomePageState createState() => HomePageState();
}

class HomePageState extends State<HomePage> {
  final _cardsController = TCardController();

  @override
  void initState() {
    super.initState();
    onInit();
  }

  Future<void> onInit() async {
    final assets = context.read<Assets>();
    final gameLogic = context.read<GameLogic>();
    await assets.load();
    gameLogic.add(const OnStartGameEvent());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Consumer<ColorPair>(
        builder: (context, colors, child) {
          return GradientBackground(
            startColor: colors.main.withOpacity(0.3),
            endColor: colors.second.withOpacity(0.3),
            child: child,
          );
        },
        child: SafeArea(
          bottom: false,
          child: Selector<ItemsState, bool>(
            builder: (context, isCompleted, _) => Stack(
              children: [
                const Align(
                  alignment: Alignment.bottomCenter,
                  child: _ItemsProgress(),
                ),
                const Align(
                  alignment: Alignment.bottomCenter,
                  child: _ScoreProgress(),
                ),
                const _ResultOrLoading(),
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
                            padding: const EdgeInsets.symmetric(horizontal: 12)
                                .copyWith(top: 12.0),
                            child: const _Headers(),
                          ),
                          Padding(
                            padding: const EdgeInsets.all(12.0),
                            child: _Cards(
                              cardsController: _cardsController,
                              constraints: constraints,
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.all(12.0),
                            child: Controls(
                              onAnswer: (isTrue) => _cardsController.forward(
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
            selector: (context, state) => state.isCompleted,
          ),
        ),
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
    return Selector<ItemsState, List<GameItem>>(
      selector: (context, state) => state.items,
      builder: (context, items, _) {
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
            context.read<GameLogic>().add(OnGuessEvent(
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
    return Consumer<ItemsState>(
      builder: (context, state, _) {
        if (state.isEmpty) {
          return const SizedBox.shrink();
        }
        return Headers(
          title: 'Is it ${state.current.capital}?',
          subtitle: state.current.country,
        );
      },
    );
  }
}

class _ResultOrLoading extends StatelessWidget {
  const _ResultOrLoading({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final isCompleted =
        context.select<ItemsState, bool>((state) => state.isCompleted);
    if (isCompleted) {
      final game = context.watch<GameLogic>();
      return Positioned.fill(
        child: BlocBuilder<GameLogic, GameState>(
          builder: (context, state) => CompleteWidget(
            score: state.score,
            topScore: state.topScore,
            onTap: () => game.add(const OnResetGameEvent()),
          ),
        ),
      );
    } else {
      return Center(
        child: Consumer<ColorPair>(
            builder: (context, colors, _) => CircularProgressIndicator(
                valueColor: AlwaysStoppedAnimation(colors.second))),
      );
    }
  }
}

class _ScoreProgress extends StatelessWidget {
  const _ScoreProgress({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Selector2<GameState, ColorPair, _ColoredProgressModel>(
      selector: (context, gameState, colorPair) =>
          _ColoredProgressModel(gameState.progress, colorPair.main),
      builder: (context, model, _) {
        return ProgressWave(
          color: model.color.withOpacity(0.6),
          progress: model.progress,
          duration: const Duration(seconds: 15),
        );
      },
    );
  }
}

class _ItemsProgress extends StatelessWidget {
  const _ItemsProgress({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Selector2<ItemsState, ColorPair, _ColoredProgressModel>(
      selector: (context, itemsState, colorPair) =>
          _ColoredProgressModel(itemsState.progress, colorPair.second),
      builder: (context, model, _) {
        return ProgressWave(
          color: model.color.withOpacity(0.6),
          progress: model.progress,
          duration: const Duration(seconds: 15),
        );
      },
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
