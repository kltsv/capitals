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
    game.addListener(_update);
    onInit();
  }

  Future<void> onInit() async {
    await assets.load();
    await game.onStartGame();
  }

  @override
  void dispose() {
    game.removeListener(_update);
    super.dispose();
  }

  List<GameItem> get items => itemsLogic.items;

  int get currentIndex => itemsLogic.currentIndex;

  bool get isCompleted => itemsLogic.isCompleted;

  ColorPair get colors => palette.colors;

  int get score => game.state.score;

  int get topScore => game.state.topScore;

  @override
  Widget build(BuildContext context) {
    if (items.isEmpty) {
      return SizedBox.shrink();
    }

    return Scaffold(
      body: GradientBackground(
        startColor: colors.main.withOpacity(0.3),
        endColor: colors.second.withOpacity(0.3),
        child: SafeArea(
          bottom: false,
          child: Stack(
            children: [
              Align(
                alignment: Alignment.bottomCenter,
                child: ProgressWave(
                  color: colors.second.withOpacity(0.6),
                  progress: itemsLogic.progress,
                  duration: Duration(seconds: 15),
                ),
              ),
              Align(
                alignment: Alignment.bottomCenter,
                child: ProgressWave(
                  color: colors.main.withOpacity(0.4),
                  progress: max(0, score) / topScore,
                ),
              ),
              isCompleted
                  ? Positioned.fill(
                      child: CompleteWidget(
                        score: score,
                        topScore: topScore,
                        onTap: () => game.onReset(),
                      ),
                    )
                  : Center(
                      child: CircularProgressIndicator(
                          valueColor: AlwaysStoppedAnimation(colors.second)),
                    ),
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
                          child: Headers(
                            title: 'Is it ${items[currentIndex].capital}?',
                            subtitle: '${items[currentIndex].country}',
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.all(12.0),
                          child: TCard(
                            slideSpeed: 25,
                            delaySlideFor: 60,
                            size: Size.square(
                              min(
                                constraints.biggest.width,
                                constraints.biggest.height / 2,
                              ),
                            ),
                            controller: _cardsController,
                            cards: items
                                .map((e) =>
                                    CapitalCard(key: ValueKey(e), item: e))
                                .toList(),
                            onForward: (index, info) {
                              game.onGuess(
                                index,
                                info.direction == SwipDirection.Right,
                              );
                            },
                          ),
                        ),
                        Padding(
                          padding: EdgeInsets.all(12.0),
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
        ),
      ),
    );
  }

  void _update() => setState(() {});
}
