import 'package:capitals/models.dart';
import 'package:flutter/material.dart';
import 'package:tcard/tcard.dart';

import 'components.dart';

TCardController _cardsController = TCardController();

void main() => runApp(const App());

class App extends StatelessWidget {
  const App({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) => const MaterialApp(home: HomePage());
}

class HomePage extends StatelessWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final items = [
      GameItem(Country('Russia', 'Moscow', imageUrls: [
        'https://images.unsplash.com/photo-1512495039889-52a3b799c9bc'
      ]))
    ];
    return Scaffold(
      body: Column(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        mainAxisSize: MainAxisSize.max,
        children: [
          Padding(
            padding:
                const EdgeInsets.symmetric(horizontal: 12).copyWith(top: 12.0),
            child: Headers(
              title: 'Is it Moscow?',
              subtitle: 'Russia',
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(12.0),
            child: TCard(
              slideSpeed: 25,
              delaySlideFor: 60,
              controller: _cardsController,
              cards: items
                  .map((e) => CapitalCard(key: ValueKey(e), item: e))
                  .toList(),
              onForward: (index, info) {
                print('Swipe: ${info.direction}');
              },
            ),
          ),
          Padding(
            padding: EdgeInsets.all(12.0),
            child: Controls(
              onAnswer: (isTrue) {
                print('Answer: $isTrue');
              },
            ),
          ),
        ],
      ),
    );
  }
}
