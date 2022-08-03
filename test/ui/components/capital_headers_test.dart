import 'package:capitals/domain/models/game_item.dart';
import 'package:capitals/domain/states/items_state.dart';
import 'package:capitals/ui/components/components.dart';
import 'package:capitals/ui/home_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:provider/provider.dart';

import '../../test_data/countries.dart';

void main() {
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
  });

  testWidgets('when there is data then headers are shown',
      (widgetTester) async {
    await widgetTester.pumpWidget(
      MaterialApp(
        home: Scaffold(
          body: Provider(
            create: (context) => const ItemsState(0, [
              GameItem(russia),
            ]),
            child: const CapitalHeaders(),
          ),
        ),
      ),
    );

    expect(find.byType(SizedBox), findsNothing);
    expect(find.byType(Headers), findsOneWidget);
    expect(find.text('Is it Moscow?'), findsOneWidget);
    expect(find.text('Russia'), findsOneWidget);
  });
}
