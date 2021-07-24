import 'dart:math';

import 'package:flutter/material.dart';
import 'package:tcard/tcard.dart';

import 'components.dart';
import 'game.dart';

final _appName = '$countryLimit Capitals';

void main() => runApp(App());

class App extends StatefulWidget {
  @override
  _AppState createState() => _AppState();
}

class _AppState extends State<App> {
  var _dark = false;

  @override
  Widget build(BuildContext context) => MaterialApp(
        title: _appName,
        builder: (context, child) => ThemeSwitch(
          isDark: _dark,
          child: child,
          onToggle: () => setState(() => _dark = !_dark),
        ),
        theme:
            ThemeData(brightness: _dark ? Brightness.dark : Brightness.light),
        home: HomePage(),
      );
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
                  progress: current / items.length,
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
                        onTap: reset,
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
