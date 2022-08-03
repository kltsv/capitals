import 'package:capitals/domain/assemble.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:integration_test/integration_test.dart';
import 'test_main.dart' as app;

void main() {
  IntegrationTestWidgetsFlutterBinding.ensureInitialized();

  testWidgets(
      'When app started then items are loaded '
      'and appear on the screen', (tester) async {
    app.main();
    while (assemble.itemsLogic.state.items.isEmpty) {
      await tester.pump();
    }
    await tester.pumpTimes(50);
    expect(find.byKey(const ValueKey('Luanda')), findsOneWidget);
    expect(find.widgetWithText(InkResponse, 'True'), findsOneWidget);
    expect(find.widgetWithText(InkResponse, 'False'), findsOneWidget);
    expect(find.text('Is it Luanda?'), findsOneWidget);
    expect(find.text('Angola'), findsOneWidget);
    expect(find.widgetWithIcon(IconButton, Icons.nightlight_round),
        findsOneWidget);

    await Future.delayed(const Duration(seconds: 5));
  });

  testWidgets('When drag cards then current item is updated', (tester) async {
    app.main();
    while (assemble.itemsLogic.state.items.isEmpty) {
      await tester.pump();
    }
    await tester.pumpTimes(50);

    final firstCard = find.byKey(const ValueKey('Luanda'));
    expect(firstCard, findsOneWidget);
    expect(find.widgetWithText(InkResponse, 'True'), findsOneWidget);
    expect(find.widgetWithText(InkResponse, 'False'), findsOneWidget);
    expect(find.text('Is it Luanda?'), findsOneWidget);
    expect(find.text('Angola'), findsOneWidget);
    expect(find.widgetWithIcon(IconButton, Icons.nightlight_round),
        findsOneWidget);

    await tester.timedDrag(
        firstCard, const Offset(-100.0, 0.0), const Duration(seconds: 1));

    await tester.pumpTimes(50);

    final secondCard = find.byKey(const ValueKey('Ankara'));
    expect(firstCard, findsNothing);
    expect(secondCard, findsOneWidget);
    expect(find.widgetWithText(InkResponse, 'True'), findsOneWidget);
    expect(find.widgetWithText(InkResponse, 'False'), findsOneWidget);
    expect(find.text('Is it Ankara?'), findsOneWidget);
    expect(find.text('Turkey'), findsOneWidget);
    expect(find.widgetWithIcon(IconButton, Icons.nightlight_round),
        findsOneWidget);

    await tester.timedDrag(
        secondCard, const Offset(100.0, 0.0), const Duration(seconds: 1));

    final thirdCard = find.byKey(const ValueKey('Tunis'));
    expect(firstCard, findsNothing);
    expect(secondCard, findsNothing);
    expect(thirdCard, findsOneWidget);
    expect(find.widgetWithText(InkResponse, 'True'), findsOneWidget);
    expect(find.widgetWithText(InkResponse, 'False'), findsOneWidget);
    expect(find.text('Is it Tunis?'), findsOneWidget);
    expect(find.text('Tunisia'), findsOneWidget);
    expect(find.widgetWithIcon(IconButton, Icons.nightlight_round),
        findsOneWidget);

    await tester.pumpTimes(50);

    await Future.delayed(const Duration(seconds: 10));
  });

  testWidgets('When tap True or False then current item is updated',
      (tester) async {
        app.main();
        while (assemble.itemsLogic.state.items.isEmpty) {
          await tester.pump();
        }
        await tester.pumpTimes(50);

        final trueButton = find.widgetWithText(InkResponse, 'True');
        final falseButton = find.widgetWithText(InkResponse, 'False');

        final firstCard = find.byKey(const ValueKey('Luanda'));
        expect(firstCard, findsOneWidget);
        expect(trueButton, findsOneWidget);
        expect(falseButton, findsOneWidget);
        expect(find.text('Is it Luanda?'), findsOneWidget);
        expect(find.text('Angola'), findsOneWidget);
        expect(find.widgetWithIcon(IconButton, Icons.nightlight_round),
            findsOneWidget);

        await tester.tap(trueButton);
        await tester.pumpTimes(50);

        final secondCard = find.byKey(const ValueKey('Ankara'));
        expect(firstCard, findsNothing);
        expect(secondCard, findsOneWidget);
        expect(trueButton, findsOneWidget);
        expect(falseButton, findsOneWidget);
        expect(find.text('Is it Ankara?'), findsOneWidget);
        expect(find.text('Turkey'), findsOneWidget);
        expect(find.widgetWithIcon(IconButton, Icons.nightlight_round),
            findsOneWidget);

        await tester.tap(falseButton);
        await tester.pumpTimes(50);

        final thirdCard = find.byKey(const ValueKey('Tunis'));
        expect(firstCard, findsNothing);
        expect(secondCard, findsNothing);
        expect(thirdCard, findsOneWidget);
        expect(trueButton, findsOneWidget);
        expect(falseButton, findsOneWidget);
        expect(find.text('Is it Tunis?'), findsOneWidget);
        expect(find.text('Tunisia'), findsOneWidget);
        expect(find.widgetWithIcon(IconButton, Icons.nightlight_round),
            findsOneWidget);

        await tester.pumpTimes(50);

        await Future.delayed(const Duration(seconds: 10));
  });
}

extension TesterExt on WidgetTester {
  Future<void> pumpTimes(
    int times, [
    Duration? duration,
    EnginePhase phase = EnginePhase.sendSemanticsUpdate,
  ]) async {
    for (var i = 0; i < times; i++) {
      await pump(duration, phase);
    }
  }
}
