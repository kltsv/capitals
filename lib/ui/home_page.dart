import 'dart:math';

import 'package:capitals/domain/assemble.dart';
import 'package:capitals/domain/items.dart';
import 'package:capitals/domain/models.dart';
import 'package:flutter/material.dart';
import 'package:tcard/tcard.dart';

import 'components.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  TCardController _cardsController = TCardController();
  final palette = Assemble.palette;
  final itemsLogic = Assemble.itemsLogic;
  final game = Assemble.game;

  @override
  void initState() {
    super.initState();
    onInit();
  }

  Future<void> onInit() async {
    await Assemble.assets.load();
    await game.onStartGame();
  }

  @override
  void dispose() {
    itemsLogic.dispose();
    palette.dispose();
    game.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: StreamBuilder<ColorPair>(
          initialData: palette.colors,
          stream: palette.stream,
          builder: (context, snapshot) {
            final colors = snapshot.requireData;
            return GradientBackground(
              startColor: colors.main.withOpacity(0.3),
              endColor: colors.second.withOpacity(0.3),
              child: SafeArea(
                bottom: false,
                child: StreamBuilder<bool>(
                    initialData: itemsLogic.state.isCompleted,
                    stream: itemsLogic.stream
                        .map((state) => state.isCompleted)
                        .distinct(),
                    builder: (context, snapshot) {
                      final isCompleted = snapshot.requireData;
                      return Stack(
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
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceEvenly,
                                  mainAxisSize: MainAxisSize.max,
                                  children: [
                                    Padding(
                                      padding: const EdgeInsets.symmetric(
                                              horizontal: 12)
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
                      );
                    }),
              ),
            );
          }),
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
    return StreamBuilder<ItemsState>(
        initialData: Assemble.itemsLogic.state,
        stream: Assemble.itemsLogic.stream,
        builder: (context, snapshot) {
          final state = snapshot.requireData;
          if (state.isEmpty) {
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
            cards: state.items
                .map((e) => CapitalCard(key: ValueKey(e), item: e))
                .toList(),
            onForward: (index, info) {
              Assemble.game.onGuess(
                index,
                info.direction == SwipDirection.Right,
              );
            },
          );
        });
  }
}

class _Headers extends StatelessWidget {
  const _Headers({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<ItemsState>(
        initialData: Assemble.itemsLogic.state,
        stream: Assemble.itemsLogic.stream,
        builder: (context, snapshot) {
          final state = snapshot.requireData;
          if (state.isEmpty) {
            return const SizedBox.shrink();
          }
          return Headers(
            title: 'Is it ${state.current.capital}?',
            subtitle: '${state.current.country}',
          );
        });
  }
}

class _ResultOrLoading extends StatelessWidget {
  const _ResultOrLoading({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<ItemsState>(
        initialData: Assemble.itemsLogic.state,
        stream: Assemble.itemsLogic.stream,
        builder: (context, snapshot) {
          final isCompleted = snapshot.requireData.isCompleted;
          return isCompleted
              ? Positioned.fill(
                  child: CompleteWidget(
                    score: Assemble.game.state.score,
                    topScore: Assemble.game.state.topScore,
                    onTap: () => Assemble.game.onReset(),
                  ),
                )
              : Center(
                  child: StreamBuilder<ColorPair>(
                      initialData: Assemble.palette.colors,
                      stream: Assemble.palette.stream,
                      builder: (context, snapshot) {
                        final colors = snapshot.requireData;
                        return CircularProgressIndicator(
                            valueColor: AlwaysStoppedAnimation(colors.second));
                      }),
                );
        });
  }
}

class _ScoreProgress extends StatelessWidget {
  const _ScoreProgress({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<double>(
        initialData: Assemble.game.state.progress,
        stream: Assemble.game.stream.map((state) => state.progress).distinct(),
        builder: (context, snapshot) {
          final progress = snapshot.requireData;
          return StreamBuilder<ColorPair>(
              initialData: Assemble.palette.colors,
              stream: Assemble.palette.stream,
              builder: (context, snapshot) {
                final colors = snapshot.requireData;
                return ProgressWave(
                  color: colors.main.withOpacity(0.6),
                  progress: progress,
                  duration: Duration(seconds: 15),
                );
              });
        });
  }
}

class _ItemsProgress extends StatelessWidget {
  const _ItemsProgress({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<double>(
        initialData: Assemble.itemsLogic.state.progress,
        stream: Assemble.itemsLogic.stream
            .map((state) => state.progress)
            .distinct(),
        builder: (context, snapshot) {
          final progress = snapshot.requireData;
          return StreamBuilder<Color>(
              initialData: Assemble.palette.colors.second,
              stream: Assemble.palette.stream
                  .map((state) => state.second)
                  .distinct(),
              builder: (context, snapshot) {
                final color = snapshot.requireData;
                return ProgressWave(
                  color: color.withOpacity(0.6),
                  progress: progress,
                  duration: Duration(seconds: 15),
                );
              });
        });
  }
}
