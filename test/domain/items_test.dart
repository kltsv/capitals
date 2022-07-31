import 'package:capitals/domain/items.dart';
import 'package:capitals/domain/models.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  group('Single GameItem', () {
    test(
        'When no fake country is provided '
        'then item returns original country and capital', () {
      const item = GameItem(russia);

      final country = item.country;
      final capital = item.capital;

      expect(country, 'Russia');
      expect(capital, 'Moscow');
    });

    test(
        'When fake country is provided '
        'then item returns fake country and capital', () {
      const item = GameItem(russia, fake: france);

      final country = item.country;
      final capital = item.capital;

      expect(country, equalsIgnoringCase('France'));
      expect(capital, equalsIgnoringCase('Paris'));
    });
  });

  group('ItemsState', () {
    test(
        'When ItemsState is initialized and current is not fake'
        'then all getters are correct', () {
      const items = <GameItem>[
        GameItem(russia),
        GameItem(italy, fake: france),
        GameItem(usa),
      ];
      const state = ItemsState(0, items);

      expect(state.current, const GameItem(russia));
      expect(state.next, const GameItem(italy, fake: france));
      expect(state.isCompleted, isFalse);
      expect(state.isCurrentTrue, isTrue);
      expect(state.originalsLength, equals(2));
      expect(state.fakeLength, equals(1));
      expect(state.progress, equals(0.0));
    });

    test(
        'When ItemsState.current is fake'
        'then all getters are correct', () {
      const items = <GameItem>[
        GameItem(russia),
        GameItem(usa),
        GameItem(france),
        GameItem(italy, fake: france),
      ];
      const state = ItemsState(3, items);

      expect(state.current, const GameItem(italy, fake: france));
      expect(state.next, isNull);
      expect(state.isCompleted, isFalse);
      expect(state.isCurrentTrue, isFalse);
      expect(state.originalsLength, equals(3));
      expect(state.fakeLength, equals(1));
      expect(state.progress, equals(0.75));
    });

    test(
        'When ItemsState.currentIndex is out of range'
        'then completed and progress is full', () {
      const items = <GameItem>[
        GameItem(france),
        GameItem(italy, fake: france),
      ];
      const state = ItemsState(2, items);

      expect(state.isCompleted, isTrue);
      expect(state.progress, equals(1));
    });
  });
}

const russia = Country('Russia', 'Moscow');
const italy = Country('Italy', 'Rome');
const usa = Country('USA', 'Washington D.C.');
const france = Country('France', 'Paris');
