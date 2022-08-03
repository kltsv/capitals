import 'dart:convert';
import 'dart:io';

import 'package:capitals/data/data.dart';
import 'package:capitals/domain/game.dart';
import 'package:capitals/domain/items.dart';
import 'package:capitals/domain/palette.dart';
import 'package:capitals/domain/states/game_state.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';

import '../test_data/countries.dart';
import 'test_domain.mocks.dart';

void main() {
  late MockRandom random;
  late MockApi api;
  late ItemsLogic itemsLogic;
  late GameLogic game;
  setUp(() async {
    random = MockRandom();
    final paletteLogic = FakePaletteLogic();
    itemsLogic = ItemsLogic(random);
    api = MockApi();
    const loader = FileJsonLoader();
    final assets = Assets(loader);
    game = GameLogic(
      random,
      api,
      assets,
      paletteLogic,
      itemsLogic,
      countryLimit: 4,
    );
    await assets.load();
  });

  test(
      'when start game then all fetch countries are in state '
      'and top score is counted', () async {
    when(random.nextInt(any)).thenAnswer((_) => 0);
    when(api.fetchCountries()).thenAnswer(
      (_) => Future.value(
        [
          russia,
          france,
          usa,
          italy,
          uk,
        ],
      ),
    );

    game.add(const OnStartGameEvent());

    game.stream.listen(expectAsync1((value) => expect(
        value,
        const GameState([
          russia,
          france,
          usa,
          italy,
          uk,
        ], 0, 8))));
  });

  test('when making guesses then current score is changing as well', () async {
    when(random.nextInt(any)).thenAnswer((_) => 0);
    when(api.fetchCountries()).thenAnswer(
      (_) => Future.value(
        [
          russia,
          france,
          usa,
          italy,
          uk,
        ],
      ),
    );

    game.add(const OnStartGameEvent());
    game.add(const OnGuessEvent(0, true));
    game.add(const OnGuessEvent(1, true));
    game.add(const OnGuessEvent(2, false));
    game.add(const OnGuessEvent(3, true));
    game.add(const OnResetGameEvent());

    expect(
      game.stream,
      emitsInOrder([
        equals(
          const GameState([
            russia,
            france,
            usa,
            italy,
            uk,
          ], 0, 8),
        ),
        equals(
          const GameState([
            russia,
            france,
            usa,
            italy,
            uk,
          ], 3, 8),
        ),
        equals(
          const GameState([
            russia,
            france,
            usa,
            italy,
            uk,
          ], 6, 8),
        ),
        equals(
          const GameState([
            russia,
            france,
            usa,
            italy,
            uk,
          ], 7, 8),
        ),
        equals(
          const GameState([
            russia,
            france,
            usa,
            italy,
            uk,
          ], 6, 8),
        ),
        equals(
          const GameState([
            russia,
            france,
            usa,
            italy,
            uk,
          ], 0, 8),
        ),
      ]),
    );
  });
}

class FileJsonLoader implements JsonLoader {
  const FileJsonLoader();

  @override
  Future<Map<String, dynamic>> load() async {
    final file = File('assets/pictures.json');
    final raw = await file.readAsString();
    final map = jsonDecode(raw) as Map<String, dynamic>;
    // Оставляем только две первые ссылки на картинку для простоты
    final smallMap = <String, dynamic>{};
    for (final entry in map.entries) {
      final list =
          (entry.value as List<dynamic>).map((e) => e.toString()).toList();
      smallMap[entry.key] =
          (list.length > 2 ? list.sublist(0, 1) : list) as dynamic;
    }
    return smallMap;
  }
}

class FakePaletteLogic extends Fake implements PaletteLogic {
  @override
  Future<void> updatePalette(ImageProvider current, ImageProvider? next) async {
    // do nothing
  }
}
