import 'dart:math';

import 'package:capitals/domain/items.dart';
import 'package:capitals/domain/models.dart';
import 'package:capitals/domain/palette.dart';
import 'package:flutter/material.dart';
import 'package:tcard/tcard.dart';

import '../data/data.dart';
import '../domain/game.dart';
import 'components.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  TCardController _cardsController = TCardController();
  final random = Random();
  final assets = Assets();
  final palette = PaletteLogic();
  late final itemsLogic = ItemsLogic(random);
  late final game = GameLogic(random, const Api(), assets, palette, itemsLogic);

  @override
  void initState() {
    super.initState();
    onInit();
  }

  Future<void> onInit() async {
    await assets.load();
    await game.onStartGame();
  }

  @override
  void dispose() {
    itemsLogic.dispose();
    game.dispose();
    super.dispose();
  }

  ColorPair get colors => palette.colors;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: GradientBackground(
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
                      child: StreamBuilder<ItemsState>(
                          initialData: itemsLogic.state,
                          stream: itemsLogic.stream,
                          builder: (context, snapshot) {
                            final progress = snapshot.requireData.progress;
                            return ProgressWave(
                              color: colors.second.withOpacity(0.6),
                              progress: progress,
                              duration: Duration(seconds: 15),
                            );
                          }),
                    ),
                    Align(
                      alignment: Alignment.bottomCenter,
                      child: StreamBuilder<GameState>(
                          initialData: game.state,
                          stream: game.stream,
                          builder: (context, snapshot) {
                            final progress = snapshot.requireData.progress;
                            return ProgressWave(
                              color: colors.main.withOpacity(0.4),
                              progress: progress,
                            );
                          }),
                    ),
                    StreamBuilder<ItemsState>(
                        initialData: itemsLogic.state,
                        stream: itemsLogic.stream,
                        builder: (context, snapshot) {
                          final isCompleted = snapshot.requireData.isCompleted;
                          return isCompleted
                              ? Positioned.fill(
                                  child: CompleteWidget(
                                    score: game.state.score,
                                    topScore: game.state.topScore,
                                    onTap: () => game.onReset(),
                                  ),
                                )
                              : Center(
                                  child: CircularProgressIndicator(
                                      valueColor: AlwaysStoppedAnimation(
                                          colors.second)),
                                );
                        }),
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
                                child: StreamBuilder<ItemsState>(
                                    initialData: itemsLogic.state,
                                    stream: itemsLogic.stream,
                                    builder: (context, snapshot) {
                                      final state = snapshot.requireData;
                                      if (state.isEmpty) {
                                        return const SizedBox.shrink();
                                      }
                                      return Headers(
                                        title:
                                            'Is it ${state.current.capital}?',
                                        subtitle: '${state.current.country}',
                                      );
                                    }),
                              ),
                              Padding(
                                padding: const EdgeInsets.all(12.0),
                                child: StreamBuilder<ItemsState>(
                                    initialData: itemsLogic.state,
                                    stream: itemsLogic.stream,
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
                                        controller: _cardsController,
                                        cards: state.items
                                            .map((e) => CapitalCard(
                                                key: ValueKey(e), item: e))
                                            .toList(),
                                        onForward: (index, info) {
                                          game.onGuess(
                                            index,
                                            info.direction ==
                                                SwipDirection.Right,
                                          );
                                        },
                                      );
                                    }),
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
      ),
    );
  }
}
