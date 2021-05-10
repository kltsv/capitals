import 'package:flutter/material.dart';

import 'components.dart';

void main() => runApp(const App());

class App extends StatelessWidget {
  const App({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) => const MaterialApp(home: HomePage());
}

class HomePage extends StatelessWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) => Scaffold(
        body: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          mainAxisSize: MainAxisSize.max,
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 12)
                  .copyWith(top: 12.0),
              child: Headers(
                title: 'Is it Moscow?',
                subtitle: 'Russia',
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(12.0),
              child: Container(),
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
