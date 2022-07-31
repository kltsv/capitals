import 'dart:async';
import 'dart:math';

import 'package:capitals/data/data.dart';
import 'package:capitals/domain/items.dart';
import 'package:capitals/logger.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'models/country.dart';
import 'models/game_item.dart';
import 'palette.dart';
import 'states/game_state.dart';
import 'states/items_state.dart';

class GameLogic extends Bloc<GameEvent, GameState> {
  static const _successGuess = 3;
  static const _successFake = 1;
  static const _fail = -1;
  static const defaultCountryLimit = 30;

  final Random _random;
  final Api _api;
  final Assets _assets;
  final PaletteLogic _palette;
  final ItemsLogic _itemsLogic;

  // Ограничение на количество стран, участвующих в игре
  final int countryLimit;

  GameLogic(
    this._random,
    this._api,
    this._assets,
    this._palette,
    this._itemsLogic, {
    this.countryLimit = GameLogic.defaultCountryLimit,
  }) : super(GameState.empty) {
    on<GameEvent>(_onGameEvent);
  }

  Future<void> _onGameEvent(GameEvent event, Emitter<GameState> emit) async {
    if (event is OnStartGameEvent) {
      await _onStartGame(event, emit);
    } else if (event is OnGuessEvent) {
      await _onGuess(event, emit);
    } else if (event is OnResetGameEvent) {
      await _onReset(event, emit);
    }
  }

  Future<void> _onStartGame(
    OnStartGameEvent event,
    Emitter<GameState> emit,
  ) async {
    var resultState = state;
    try {
      var countries = await _api.fetchCountries();
      countries = _countryWithImages(countries);
      // Сохраняем в состояние все доступные страны,
      // для которых есть картинки
      resultState = resultState.copyWith(countries: [...countries]);
      final limitedCountries = _getCountriesForNewGame(countries);
      _itemsLogic.updateItems(limitedCountries);
      resultState = _prepareItems(resultState, limitedCountries);
    } catch (e, s) {
      // TODO handle error
      logger.severe(e, s);
    }
    await _updatePalette(_itemsLogic.state);
    emit(resultState);
  }

  Future<void> _onReset(
    OnResetGameEvent event,
    Emitter<GameState> emit,
  ) async {
    _itemsLogic.reset();
    final limitedCountries = _getCountriesForNewGame(state.countries);
    _itemsLogic.updateItems(limitedCountries);
    final newState = _prepareItems(
      state.copyWith(score: 0),
      limitedCountries,
    );
    emit(newState);
  }

  Future<void> _onGuess(
    OnGuessEvent event,
    Emitter<GameState> emit,
  ) async {
    final index = event.index;
    final isTrue = event.isTrue;
    final isActuallyTrue = _itemsLogic.state.isCurrentTrue;
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
    _itemsLogic.updateCurrent(index);

    final itemsState = _itemsLogic.state;
    if (!itemsState.isCompleted) {
      await _updatePalette(itemsState);
    }
    emit(_updateScore(state, state.score + scoreUpdate));
  }

  List<Country> _getCountriesForNewGame(List<Country> countries) {
    final copyToShuffle = [...countries];
    copyToShuffle.shuffle(_random);
    // выбираем только органиченное число стран для игры
    return copyToShuffle.sublist(0, countryLimit);
  }

  Future<void> _updatePalette(ItemsState state) =>
      _palette.updatePalette(state.current.image, state.next?.image);

  GameState _updateScore(GameState state, int score) =>
      state.copyWith(score: score);

  GameState _updateTopScore(GameState state, int topScore) =>
      state.copyWith(topScore: topScore);

  GameState _prepareItems(GameState state, List<Country> countries) {
    final originals = _itemsLogic.state.originalsLength;
    final fakes = _itemsLogic.state.fakeLength;
    final topScore = originals * _successGuess + fakes * _successFake;
    return _updateTopScore(state, topScore);
  }

  List<Country> _countryWithImages(List<Country> countries) => countries
      .where((element) => element.capital.isNotEmpty)
      .map((e) {
        final imageUrls = _assets.capitalPictures(e.capital);
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

  @override
  void onTransition(Transition<GameEvent, GameState> transition) {
    super.onTransition(transition);
    logger.fine(
      'Bloc: ${transition.event.runtimeType}:'
      ' ${transition.currentState.score}/${transition.currentState.topScore} '
      '-> ${transition.nextState.score}/${transition.currentState.topScore}',
    );
  }
}

abstract class GameEvent {
  const GameEvent();
}

class OnStartGameEvent implements GameEvent {
  const OnStartGameEvent();
}

class OnResetGameEvent implements GameEvent {
  const OnResetGameEvent();
}

class OnGuessEvent implements GameEvent {
  final int index;
  final bool isTrue;

  const OnGuessEvent(this.index, this.isTrue);
}
