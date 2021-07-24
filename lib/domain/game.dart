import 'dart:math';

import 'package:capitals/data/data.dart';
import 'package:capitals/domain/items.dart';
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

  final Random _random;
  final Api _api;
  final PaletteLogic _palette;
  final ItemsLogic _itemsLogic;

  GameLogic(
    this._random,
    this._api,
    this._palette,
    this._itemsLogic,
  );

  Future<void> onStartGame() async {
    try {
      var countries = await _api.fetchCountries();
      countries = _countryWithImages(countries);
      countries.shuffle(_random);
      countries = countries.sublist(0, countryLimit);
      _prepareItems(countries);
    } catch (e) {
      // TODO handle error
      print(e);
    }
    await _updatePalette();
  }

  Future<void> onReset() async {
    _updateScore(0);
    _updateTopScore(0);
    _itemsLogic.reset();
  }

  Future<void> onGuess(int index, bool isTrue) async {
    final isActuallyTrue = _itemsLogic.isCurrentTrue;
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
    _itemsLogic.updateCurrent(index);

    await _updatePalette();
  }

  Future<void> _updatePalette() => _palette.updatePalette(
      _itemsLogic.current.image, _itemsLogic.next?.image);

  void _updateScore(int score) => _setState(() => this.score = score);

  void _updateTopScore(int topScore) =>
      _setState(() => this.topScore = topScore);

  void _prepareItems(List<Country> countries) {
    _itemsLogic.updateItems(countries);
    final originals = _itemsLogic.originalsLength;
    final fakes = _itemsLogic.fakeLength;
    _updateTopScore(topScore + originals * _successGuess);
    _updateTopScore(topScore + fakes * _successFake);
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
