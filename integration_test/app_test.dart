import 'dart:async';
import 'dart:math';

import 'package:capitals/domain/assemble.dart';
import 'package:capitals/keys.dart';
import 'package:capitals/ui/app.dart';
import 'package:capitals/ui/components/components.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:integration_test/integration_test.dart';
import 'package:logging/logging.dart';

import 'test_main.dart' as test_app;
import 'package:capitals/main.dart' as app;

final testLogger = Logger('[Test]');

void main() {
  IntegrationTestWidgetsFlutterBinding.ensureInitialized();
  late final StreamSubscription loggerSub;

  setUpAll(() {
    loggerSub = testLogger.onRecord
        // ignore: avoid_print
        .listen((event) => print('${event.time}: $event'));
  });

  tearDownAll(() async => await loggerSub.cancel());

  // Сбрасываем контейнер getIt после каждого теста
  tearDown(() {
    resetSimpleUI();
    getIt.reset();
  });

  testWidgets(
      'When app started then items are loaded '
      'and appear on the screen', (tester) async {
    test_app.main();

    // Итерируемся по фреймам до тех пор,
    // пока в состоянии не появятся айтемы
    while (assemble.itemsLogic.state.items.isEmpty) {
      await tester.pump();
    }
    await tester.pumpTimes(60);

    // Проверяем наличие всех необходимых виджетов на экране
    expect(find.byKey(const ValueKey('Luanda')), findsOneWidget);
    expect(find.widgetWithText(InkResponse, 'True'), findsOneWidget);
    expect(find.widgetWithText(InkResponse, 'False'), findsOneWidget);
    expect(find.text('Is it Luanda?'), findsOneWidget);
    expect(find.text('Angola'), findsOneWidget);
    expect(find.widgetWithIcon(IconButton, Icons.nightlight_round),
        findsOneWidget);

    // Проверяем наличие виджетов с прогрессом (с волнами)
    // и убеждаемся, что прогресс равен 0
    final scoreProgress = find.byWidgetPredicate(
      (widget) =>
          widget.key == Keys.scoreProgressWave &&
          widget is ProgressWave &&
          widget.progress == 0,
    );
    expect(scoreProgress, findsOneWidget);
    final itemsProgress = find.byWidgetPredicate(
      (widget) =>
          widget.key == Keys.itemsProgressWave &&
          widget is ProgressWave &&
          widget.progress == 0,
    );
    expect(itemsProgress, findsOneWidget);

    await waitSec(3);
  });

  testWidgets('When drag cards then current item is updated', (tester) async {
    test_app.main();
    _simplifyUI();

    while (assemble.itemsLogic.state.items.isEmpty) {
      await tester.pump();
    }
    await tester.pumpTimes(60);

    final firstCard = find.byKey(const ValueKey('Luanda'));
    expect(firstCard, findsOneWidget);
    expect(find.widgetWithText(InkResponse, 'True'), findsOneWidget);
    expect(find.widgetWithText(InkResponse, 'False'), findsOneWidget);
    expect(find.text('Is it Luanda?'), findsOneWidget);
    expect(find.text('Angola'), findsOneWidget);
    expect(find.widgetWithIcon(IconButton, Icons.nightlight_round),
        findsOneWidget);
    var scoreProgress = find.byKey(Keys.scoreProgressWave);
    var scoreSize = tester.getSize(scoreProgress);
    expect(scoreProgress, findsOneWidget);
    var itemsProgress = find.byKey(Keys.itemsProgressWave);
    var itemsSize = tester.getSize(itemsProgress);
    expect(itemsProgress, findsOneWidget);

    await expectLater(
      find.byType(App),
      matchesGoldenFile(goldenFileName('drag_0')),
    );

    // Делаем свайп влево
    await tester.timedDrag(
      firstCard,
      Offset(tester.percentsOfScreen(0.5), 0.0),
      const Duration(seconds: 1),
    );
    // И итерируемся по кадрам, чтобы виджет улетел
    await tester.pumpTimes(60);

    // Проверяем, что старой карточки уже нет, а виджеты обновились
    expect(firstCard, findsNothing);
    final secondCard = find.byKey(const ValueKey('Ankara'));
    expect(secondCard, findsOneWidget);
    expect(find.widgetWithText(InkResponse, 'True'), findsOneWidget);
    expect(find.widgetWithText(InkResponse, 'False'), findsOneWidget);
    expect(find.text('Is it Ankara?'), findsOneWidget);
    expect(find.text('Turkey'), findsOneWidget);
    expect(find.widgetWithIcon(IconButton, Icons.nightlight_round),
        findsOneWidget);

    // Проверяем, что прогресс очков и айтемов изменился
    scoreProgress = find.byKey(Keys.scoreProgressWave);
    expect(scoreProgress, findsOneWidget);
    var prevScoreSize = scoreSize;
    scoreSize = tester.getSize(scoreProgress);
    testLogger.info('Score size: prev=$prevScoreSize, crt=$scoreSize');
    expect(prevScoreSize.height < scoreSize.height, isTrue);
    itemsProgress = find.byKey(Keys.itemsProgressWave);
    expect(itemsProgress, findsOneWidget);
    var prevItemsSize = itemsSize;
    itemsSize = tester.getSize(itemsProgress);
    testLogger.info('Items size: prev=$prevItemsSize, crt=$itemsSize');
    expect(prevItemsSize.height < itemsSize.height, isTrue);

    await expectLater(
      find.byType(App),
      matchesGoldenFile(goldenFileName('drag_1')),
    );

    await tester.timedDrag(
      secondCard,
      Offset(-tester.percentsOfScreen(0.5), 0.0),
      const Duration(seconds: 1),
    );
    await tester.pumpTimes(60);

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

    // Проверяем, что прогресс очков изменился в меньшую сторону,
    // потому что мы ответили неправильно
    scoreProgress = find.byKey(Keys.scoreProgressWave);
    expect(scoreProgress, findsOneWidget);
    prevScoreSize = scoreSize;
    scoreSize = tester.getSize(scoreProgress);
    testLogger.info('Score size: prev=$prevScoreSize, crt=$scoreSize');
    expect(prevScoreSize.height > scoreSize.height, isTrue);

    // При этом прогресс айтемов тоже изменился,
    // потому что до конца их осталось меньше
    itemsProgress = find.byKey(Keys.itemsProgressWave);
    expect(itemsProgress, findsOneWidget);
    prevItemsSize = itemsSize;
    itemsSize = tester.getSize(itemsProgress);
    testLogger.info('Items size: prev=$prevItemsSize, crt=$itemsSize');
    expect(prevItemsSize.height < itemsSize.height, isTrue);

    await expectLater(
      find.byType(App),
      matchesGoldenFile(goldenFileName('drag_2')),
    );

    await tester.pumpAndWait(waitSeconds: 3);
  });

  testWidgets('When tap True or False then current item is updated',
      (tester) async {
    // Делаем всё то же самое, что и в предыдущем тесте,
    // но проверяя тапы на кнопки True/False
    // и в другом порядке (сначала false, потом true)

    test_app.main();
    _simplifyUI();

    while (assemble.itemsLogic.state.items.isEmpty) {
      await tester.pump();
    }
    await tester.pumpTimes(60);

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
    var scoreProgress = find.byKey(Keys.scoreProgressWave);
    var scoreSize = tester.getSize(scoreProgress);
    expect(scoreProgress, findsOneWidget);
    var itemsProgress = find.byKey(Keys.itemsProgressWave);
    var itemsSize = tester.getSize(itemsProgress);
    expect(itemsProgress, findsOneWidget);

    await expectLater(
      find.byType(App),
      matchesGoldenFile(goldenFileName('tap_0')),
    );

    await tester.tap(falseButton);
    await tester.pumpTimes(60);

    final secondCard = find.byKey(const ValueKey('Ankara'));
    expect(firstCard, findsNothing);
    expect(secondCard, findsOneWidget);
    expect(trueButton, findsOneWidget);
    expect(falseButton, findsOneWidget);
    expect(find.text('Is it Ankara?'), findsOneWidget);
    expect(find.text('Turkey'), findsOneWidget);
    expect(find.widgetWithIcon(IconButton, Icons.nightlight_round),
        findsOneWidget);

    scoreProgress = find.byKey(Keys.scoreProgressWave);
    expect(scoreProgress, findsOneWidget);
    var prevScoreSize = scoreSize;
    scoreSize = tester.getSize(scoreProgress);
    testLogger.info('Score size: prev=$prevScoreSize, crt=$scoreSize');
    expect(prevScoreSize.height == scoreSize.height, isTrue);
    itemsProgress = find.byKey(Keys.itemsProgressWave);
    expect(itemsProgress, findsOneWidget);
    var prevItemsSize = itemsSize;
    itemsSize = tester.getSize(itemsProgress);
    testLogger.info('Items size: prev=$prevItemsSize, crt=$itemsSize');
    expect(prevItemsSize.height < itemsSize.height, isTrue);

    await expectLater(
      find.byType(App),
      matchesGoldenFile(goldenFileName('tap_1')),
    );

    await tester.tap(trueButton);
    await tester.pumpTimes(60);

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

    scoreProgress = find.byKey(Keys.scoreProgressWave);
    expect(scoreProgress, findsOneWidget);
    prevScoreSize = scoreSize;
    scoreSize = tester.getSize(scoreProgress);
    testLogger.info('Score size: prev=$prevScoreSize, crt=$scoreSize');
    expect(prevScoreSize.height < scoreSize.height, isTrue);
    itemsProgress = find.byKey(Keys.itemsProgressWave);
    expect(itemsProgress, findsOneWidget);
    prevItemsSize = itemsSize;
    itemsSize = tester.getSize(itemsProgress);
    testLogger.info('Items size: prev=$prevItemsSize, crt=$itemsSize');
    expect(prevItemsSize.height < itemsSize.height, isTrue);

    await expectLater(
      find.byType(App),
      matchesGoldenFile(goldenFileName('tap_2')),
    );

    await tester.pumpAndWait(waitSeconds: 3);
  });

  testWidgets('When full game completed then final score is shown',
      (tester) async {
    // Проходим полный флоу игры до экрана с результатами

    // Запускаем полностью продовое окружение
    app.main();
    while (assemble.itemsLogic.state.items.isEmpty) {
      await tester.pump();
    }
    await tester.pumpTimes(60);

    // Убеждаемся, что на старте приложения
    // в продовом окружении, тестовые флаги изменены
    expect(ProgressWave.simplify, isFalse);
    expect(GradientBackground.simplify, isFalse);

    expect(find.byType(Headers), findsOneWidget);
    expect(find.byType(Controls), findsOneWidget);

    final random = Random();

    for (var i = 0; i < 29; i++) {
      final shouldDrag = random.nextBool();
      final guessTrue = random.nextBool();

      final card = find.byType(CapitalCard);
      if (shouldDrag) {
        // Делаем свайп влево
        await tester.timedDrag(
          card.last,
          Offset((guessTrue ? 1 : -1) * tester.percentsOfScreen(0.5), 0.0),
          const Duration(milliseconds: 200),
        );
        // И итерируемся по кадрам, чтобы виджет улетел
      } else {
        await tester.tap(
            find.widgetWithText(InkResponse, guessTrue ? 'True' : 'False'));
      }
      await tester.pumpTimes(60);

      expect(card, findsWidgets);
      expect(find.byType(Headers), findsOneWidget);
      expect(find.byType(Controls), findsOneWidget);
      expect(find.widgetWithIcon(IconButton, Icons.nightlight_round),
          findsOneWidget);

      testLogger.fine(
          '${assemble.itemsLogic.state.currentIndex}: ${assemble.itemsLogic.state.items.map((e) => e.original.capital)}');
    }

    // Угадываем последнюю карточку
    await tester.tap(find.widgetWithText(InkResponse, 'True'));
    await tester.pumpTimes(60);

    expect(find.byType(CapitalCard), findsNothing);
    expect(find.byType(Headers), findsNothing);
    expect(find.byType(Controls), findsNothing);
    final complete = find.byType(CompleteWidget);
    expect(complete, findsOneWidget);
    expect(find.text('Your result'), findsOneWidget);
    expect(find.byKey(Keys.scoreResult), findsOneWidget);
    expect(find.byKey(Keys.maxResult), findsOneWidget);

    await waitSec(3);

    // Тапаем по виджету завершения и проверяем, что игра началась заново
    await tester.tap(complete);
    await tester.pumpTimes(60);

    expect(complete, findsNothing);
    expect(find.byType(CapitalCard), findsWidgets);
    expect(find.byType(Headers), findsOneWidget);
    expect(find.byType(Controls), findsOneWidget);
    expect(find.widgetWithIcon(IconButton, Icons.nightlight_round),
        findsOneWidget);

    // Убеждаемся, что в результате работы приложения
    // в продовом окружении, тестовые флаги не переключались
    expect(ProgressWave.simplify, isFalse);
    expect(GradientBackground.simplify, isFalse);

    await waitSec(3);
  });

  testWidgets('Light/dark mode switching', (tester) async {
    app.main();

    await tester.pumpTimes(60);

    Element context() => tester.element(find.byType(Scaffold));

    expect(Theme.of(context()).brightness, Brightness.light);

    await tester.tap(find.widgetWithIcon(IconButton, Icons.nightlight_round));
    await tester.pumpTimes(60);
    await Future.delayed(const Duration(seconds: 1));

    expect(Theme.of(context()).brightness, Brightness.dark);

    await tester.tap(find.widgetWithIcon(IconButton, Icons.wb_sunny_outlined));
    await tester.pumpTimes(60);
    await Future.delayed(const Duration(seconds: 1));

    expect(Theme.of(context()).brightness, Brightness.light);

    await tester.tap(find.widgetWithIcon(IconButton, Icons.nightlight_round));
    await tester.pumpTimes(60);
    await Future.delayed(const Duration(seconds: 1));

    expect(Theme.of(context()).brightness, Brightness.dark);

    await Future.delayed(const Duration(seconds: 3));
  });
}

Future<void> waitSec(int seconds) => Future.delayed(Duration(seconds: seconds));

extension TesterExt on WidgetTester {
  Future<void> pumpAndWait({
    int pumpTimes = 60,
    int? waitSeconds,
    Duration? pumpDuration,
  }) async {
    for (var i = 0; i < pumpTimes; i++) {
      await pump(pumpDuration);
    }
    if (waitSeconds != null) {
      waitSec(waitSeconds);
    }
  }

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

extension SwipeTesterExt on WidgetTester {
  double percentsOfScreen(double percents, {Axis axis = Axis.horizontal}) {
    final size = MediaQuery.of(element(find.byType(Scaffold))).size;
    return (axis == Axis.horizontal ? size.width : size.height) * percents;
  }
}

/// Включить упрощенный UI
void _simplifyUI() {
  ProgressWave.simplify = true;
  GradientBackground.simplify = true;
}

// Отключить упрощенный UI
void resetSimpleUI() {
  ProgressWave.simplify = false;
  GradientBackground.simplify = false;
}

String goldenFileName(String name) {
  const goldensDir = 'goldens/';
  const expectedExt = '.png';
  assert(
    !name.endsWith(expectedExt),
    'Use name without extension — it will be added automatically by this method',
  );
  final platform = defaultTargetPlatform.name.toLowerCase();
  return '$goldensDir${name}_$platform$expectedExt';
}
