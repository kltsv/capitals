import 'dart:async';
import 'dart:math';

import 'package:capitals/data/data.dart';
import 'package:capitals/domain/items.dart';
import 'package:capitals/logger.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'models.dart';
import 'palette.dart';

class GameState {
  static const GameState empty = GameState(0, 1);

  final int score;
  final int topScore;

  const GameState(this.score, this.topScore);

  double get progress => max(0, score) / topScore;

  GameState copyWith({
    int? score,
    int? topScore,
  }) =>
      GameState(
        score ?? this.score,
        topScore ?? this.topScore,
      );
}

class GameLogic extends Bloc<GameEvent, GameState> {
  static const _successGuess = 3;
  static const _successFake = 1;
  static const _fail = -1;
  static const countryLimit = 30;

  final Random _random;
  final Api _api;
  final Assets _assets;
  final PaletteLogic _palette;
  final ItemsLogic _itemsLogic;

  GameLogic(
    this._random,
    this._api,
    this._assets,
    this._palette,
    this._itemsLogic,
  ) : super(GameState.empty) {
    on<OnStartGameEvent>(_onStartGame);
    on<OnResetGameEvent>(_onReset);
    on<OnGuessEvent>(_onGuess);
  }

  Future<void> _onStartGame(
    OnStartGameEvent event,
    Emitter<GameState> emit,
  ) async {
    var resultState = state;
    try {
      var countries = await _api.fetchCountries();
      countries = _countryWithImages(countries);
      countries.shuffle(_random);
      countries = countries.sublist(0, countryLimit);
      resultState = _prepareItems(resultState, countries);
    } catch (e, s) {
      // TODO handle error
      logger.severe(e, s);
    }
    await _updatePalette();
    emit(resultState);
  }

  Future<void> _onReset(
    OnResetGameEvent event,
    Emitter<GameState> emit,
  ) async {
    _itemsLogic.reset();
    final newState = _prepareItems(
      state.copyWith(score: 0),
      _itemsLogic.state.items.map((e) => e.original).toList(),
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
    final resultState = _updateScore(state, state.score + scoreUpdate);
    _itemsLogic.updateCurrent(index);

    if (!_itemsLogic.state.isCompleted) {
      await _updatePalette();
    }
    emit(resultState);
  }

  Future<void> _updatePalette() => _palette.updatePalette(
      _itemsLogic.state.current.image, _itemsLogic.state.next?.image);

  GameState _updateScore(GameState state, int score) =>
      state.copyWith(score: score);

  GameState _updateTopScore(GameState state, int topScore) =>
      state.copyWith(topScore: topScore);

  GameState _prepareItems(GameState state, List<Country> countries) {
    _itemsLogic.updateItems(countries);
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
