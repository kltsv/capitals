import 'dart:math';

import 'package:capitals/domain/assemble.dart';
import 'package:capitals/domain/palette.dart';
import 'package:capitals/domain/store.dart';
import 'package:redux/redux.dart';
import 'package:redux_thunk/redux_thunk.dart';

import 'models.dart';

const _successGuess = 3;
const _successFake = 1;
const _fail = -1;
const countryLimit = 30;

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

final gameReducers = combineReducers<GameState>([
  TypedReducer<GameState, UpdateScoreAction>(_updateScore),
  TypedReducer<GameState, UpdateTopScoreAction>(_updateTopScore),
]);

class UpdateScoreAction {
  final int score;

  const UpdateScoreAction(this.score);
}

class UpdateTopScoreAction {
  final int topScore;

  const UpdateTopScoreAction(this.topScore);
}

GameState _updateScore(GameState state, UpdateScoreAction action) =>
    state.copyWith(score: action.score);

GameState _updateTopScore(GameState state, UpdateTopScoreAction action) =>
    state.copyWith(topScore: action.topScore);

class OnStartGameThunk
    extends CallableThunkActionWithExtraArgument<GlobalState, Assemble> {
  @override
  call(Store<GlobalState> store, Assemble service) async {
    try {
      var countries = await service.api.fetchCountries();
      countries = _countryWithImages(service, countries);
      countries.shuffle(service.random);
      countries = countries.sublist(0, countryLimit);

      // TODO use dispatch
      service.itemsLogic.updateItems(countries);

      final originals = service.itemsLogic.state.originalsLength;
      final fakes = service.itemsLogic.state.fakeLength;
      final topScore = originals * _successGuess + fakes * _successFake;
      store.dispatch(UpdateTopScoreAction(topScore));
    } catch (e) {
      // TODO handle error
      print(e);
    }
    store.dispatch(UpdatePaletteThunk(service.itemsLogic.state.current.image,
        service.itemsLogic.state.next?.image));
  }

  List<Country> _countryWithImages(Assemble service, List<Country> countries) =>
      countries
          .where((element) => element.capital.isNotEmpty)
          .map((e) {
            final imageUrls = service.assets.capitalPictures(e.capital);
            if (imageUrls.isNotEmpty) {
              final randomIndex = service.random.nextInt(imageUrls.length);
              return Country(e.name, e.capital,
                  imageUrls: imageUrls, index: randomIndex);
            } else {
              return Country(e.name, e.capital,
                  imageUrls: imageUrls, index: -1);
            }
          })
          .where((element) => element.index != -1)
          .toList();
}

class OnGuessThunk
    extends CallableThunkActionWithExtraArgument<GlobalState, Assemble> {
  final int index;
  final bool isTrue;

  OnGuessThunk(this.index, this.isTrue);

  @override
  call(Store<GlobalState> store, Assemble service) async {
    final isActuallyTrue = service.itemsLogic.state.isCurrentTrue;
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
    store.dispatch(UpdateScoreAction(store.state.game.score + scoreUpdate));

    // TODO use dispatch
    service.itemsLogic.updateCurrent(index);

    // TODO use dispatch (and itemsState)
    if (!service.itemsLogic.state.isCompleted) {
      store.dispatch(UpdatePaletteThunk(service.itemsLogic.state.current.image,
          service.itemsLogic.state.next?.image));
    }
  }
}

class OnResetThunk
    extends CallableThunkActionWithExtraArgument<GlobalState, Assemble> {
  @override
  call(Store<GlobalState> store, Assemble service) {
    store.dispatch(UpdateScoreAction(0));
    store.dispatch(UpdateTopScoreAction(1));

    service.itemsLogic.reset();

    // TODO use dispatch
    service.itemsLogic.updateItems(
        service.itemsLogic.state.items.map((e) => e.original).toList());

    final originals = service.itemsLogic.state.originalsLength;
    final fakes = service.itemsLogic.state.fakeLength;
    final topScore = originals * _successGuess + fakes * _successFake;
    store.dispatch(UpdateTopScoreAction(topScore));
  }
}
