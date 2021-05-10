import 'dart:math';

import 'package:flutter/material.dart';
import 'package:tcard/tcard.dart';

import 'components.dart';
import 'game.dart';

void main() => runApp(const App());

class App extends StatelessWidget {
  const App({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) => const MaterialApp(home: HomePage());
}

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> with GameMixin<HomePage> {
  TCardController _cardsController = TCardController();

  @override
  void initState() {
    super.initState();
    onInit();
  }

  @override
  Widget build(BuildContext context) {
    if (items.isEmpty) {
      return SizedBox.shrink();
    }

    var mainColor = currentPalette?.mutedColor?.color;
    var secondColor = currentPalette?.vibrantColor?.color;
    final defaultColor =
        mainColor ?? secondColor ?? Theme.of(context).backgroundColor;
    mainColor = mainColor ?? defaultColor;
    secondColor = secondColor ?? defaultColor;

    return Scaffold(
      body: GradientBackground(
        startColor: mainColor.withOpacity(0.3),
        endColor: secondColor.withOpacity(0.3),
        child: SafeArea(
          child: Stack(
            children: [
              Align(
                alignment: Alignment.bottomCenter,
                child: ProgressWave(
                  color: secondColor.withOpacity(0.6),
                  progress: current / items.length,
                  duration: Duration(seconds: 15),
                ),
              ),
              Align(
                alignment: Alignment.bottomCenter,
                child: ProgressWave(
                  color: mainColor.withOpacity(0.4),
                  progress: max(0, score) / topScore,
                ),
              ),
              isCompleted
                  ? Positioned.fill(
                      child: CompleteWidget(
                        score: score,
                        topScore: topScore,
                        onTap: reset,
                      ),
                    )
                  : Center(
                      child: CircularProgressIndicator(
                          valueColor: AlwaysStoppedAnimation(secondColor)),
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
                            title: 'Is it ${items[current].capital}?',
                            subtitle: '${items[current].country}',
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
                              onGuess(
                                index,
                                info.direction == SwipDirection.Right,
                                items[current].fake != null,
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
}
