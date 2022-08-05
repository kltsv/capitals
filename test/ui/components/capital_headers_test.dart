import 'package:capitals/domain/models/game_item.dart';
import 'package:capitals/domain/states/items_state.dart';
import 'package:capitals/ui/components/components.dart';
import 'package:capitals/ui/home_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:golden_toolkit/golden_toolkit.dart';
import 'package:provider/provider.dart';

import '../../test_data/countries.dart';

Future<void> main() async {
  await loadAppFonts();

  testWidgets('when no data then no headers', (widgetTester) async {
    await widgetTester.pumpWidget(
      MaterialApp(
        home: Scaffold(
          body: Provider(
            create: (context) => ItemsState.empty,
            child: const CapitalHeaders(),
          ),
        ),
      ),
    );

    expect(find.byType(SizedBox), findsOneWidget);
    expect(find.byType(Headers), findsNothing);

    await expectLater(
      find.byType(CapitalHeaders),
      matchesGoldenFile('goldens/capital_headers_empty.png'),
    );
  });

  testWidgets('when there is data then headers are shown',
      (widgetTester) async {
    await widgetTester.pumpWidget(
      MaterialApp(
        home: Scaffold(
          body: Stack(
            children: [
              Provider(
                create: (context) => const ItemsState(0, [
                  GameItem(russia),
                ]),
                child: const CapitalHeaders(),
              ),
            ],
          ),
        ),
      ),
    );

    expect(find.byType(SizedBox), findsNothing);
    expect(find.byType(Headers), findsOneWidget);
    expect(find.text('Is it Moscow?'), findsOneWidget);
    expect(find.text('Russia'), findsOneWidget);

    await expectLater(
      find.byType(CapitalHeaders),
      matchesGoldenFile('goldens/capital_headers_data.png'),
    );
  });
}
