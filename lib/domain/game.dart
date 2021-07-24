import 'dart:math';

import 'package:capitals/data/data.dart';
import 'package:flutter/foundation.dart';

import 'models.dart';
import 'palette.dart';

class GameLogic extends ChangeNotifier {
  static const _successGuess = 3;
  static const _successFake = 1;
  static const _fail = -1;
  static const countryLimit = 30;

  var topScore = 0;
  var score = 0;
  var current = 0;

  final items = <GameItem>[];

  final Random _random;
  final Api _api;
  final PaletteLogic _palette;

  GameLogic(
    this._random,
    this._api,
    this._palette,
  );

  bool get isCompleted => current == items.length;

  Future<void> onStartGame() async {
    try {
      var countries = await _api.fetchCountries();
      countries = _countryWithImages(countries);
      countries.shuffle(_random);
      countries = countries.sublist(0, countryLimit);
      _updateItems(countries);
    } catch (e) {
      // TODO handle error
      print(e);
    }
    await _updatePalette();
  }

  Future<void> onReset() async {
    _updateCurrent(0);
    _updateScore(0);
    _updateTopScore(0);
    final countries = items.map((e) => e.original).toList();
    _updateItems(countries);
  }

  Future<void> onGuess(int index, bool isTrue) async {
    final isActuallyTrue = items[current].fake != null;
    var scoreUpdate = 0;
    if (isTrue && isActuallyTrue) {
      scoreUpdate = _successGuess;
    }
    if (!isTrue && !isActuallyTrue) {
      scoreUpdate = _successFake;
    }
    if (isTrue && !isActuallyTrue || !isTrue && isActuallyTrue) {
      scoreUpdate = _fail;
    }
    _updateScore(score + scoreUpdate);
    _updateCurrent(index);

    await _updatePalette();
  }

  Future<void> _updatePalette() => _palette.updatePalette(items[current].image,
      (current + 1) < items.length ? items[current + 1].image : null);

  void _updateCurrent(int current) => _setState(() => this.current = current);

  void _updateScore(int score) => _setState(() => this.score = score);

  void _updateTopScore(int topScore) =>
      _setState(() => this.topScore = topScore);

  void _updateItems(List<Country> countries) {
    final originals = countries.sublist(0, countries.length ~/ 2);
    _updateTopScore(topScore + originals.length * _successGuess);
    final fakes = countries.sublist(countries.length ~/ 2, countries.length);
    _updateTopScore(topScore + fakes.length * _successFake);
    fakes.shuffle(_random);
    final list = <GameItem>[];
    list.addAll(originals.map((e) => GameItem(e)));
    for (var i = 0; i < fakes.length; i++) {
      list.add(GameItem(fakes[i], fake: fakes[(i + 1) % fakes.length]));
    }
    list.shuffle(_random);
    _setState(() {
      items.clear();
      items.addAll(list);
    });
  }

  List<Country> _countryWithImages(List<Country> countries) => countries
      .where((element) => element.capital.isNotEmpty)
      .map((e) {
        final imageUrls = Assets.capitalPictures(e.capital);
        if (imageUrls.isNotEmpty) {
          final randomIndex = _random.nextInt(imageUrls.length);
          return Country(e.name, e.capital,
              imageUrls: imageUrls, index: randomIndex);
        } else {
          return Country(e.name, e.capital, imageUrls: imageUrls, index: -1);
        }
      })
      .where((element) => element.index != -1)
      .toList();

  void _setState(VoidCallback callback) {
    callback();
    notifyListeners();
  }
}
