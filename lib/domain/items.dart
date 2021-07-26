import 'package:redux/redux.dart';
import 'package:redux_thunk/redux_thunk.dart';

import 'assemble.dart';
import 'models.dart';
import 'store.dart';

class ItemsState {
  static const empty = ItemsState(0, []);

  final int currentIndex;
  final List<GameItem> items;

  const ItemsState(this.currentIndex, this.items);

  GameItem get current => items[currentIndex];

  GameItem? get next =>
      ((currentIndex + 1) < items.length) ? items[currentIndex + 1] : null;

  bool get isCompleted => items.isNotEmpty && currentIndex == items.length;

  bool get isEmpty => items.isEmpty;

  bool get isCurrentTrue => current.fake == null;

  int get originalsLength =>
      items.where((element) => element.fake == null).length;

  int get fakeLength => items.length - originalsLength;

  double get progress => isEmpty ? 0 : currentIndex / items.length;

  ItemsState copyWith({
    int? currentIndex,
    List<GameItem>? items,
  }) =>
      ItemsState(
        currentIndex ?? this.currentIndex,
        items ?? this.items,
      );
}

final itemsReducers = combineReducers<ItemsState>([
  TypedReducer<ItemsState, UpdateCurrentAction>(_updateCurrent),
  TypedReducer<ItemsState, _UpdateItemsAction>(_updateItems),
]);

class UpdateCurrentAction {
  final int current;

  const UpdateCurrentAction(this.current);
}

class _UpdateItemsAction {
  final List<GameItem> items;

  const _UpdateItemsAction(this.items);
}

ItemsState _updateCurrent(ItemsState state, UpdateCurrentAction action) =>
    state.copyWith(currentIndex: action.current);

ItemsState _updateItems(ItemsState state, _UpdateItemsAction action) =>
    state.copyWith(items: action.items);

class UpdateItemsThunk
    extends CallableThunkActionWithExtraArgument<GlobalState, Assemble> {
  final List<Country> countries;

  UpdateItemsThunk(this.countries);

  @override
  call(Store<GlobalState> store, Assemble service) {
    final originals = countries.sublist(0, countries.length ~/ 2);
    final fakes = countries.sublist(countries.length ~/ 2, countries.length);
    fakes.shuffle(service.random);
    final list = <GameItem>[];
    list.addAll(originals.map((e) => GameItem(e)));
    for (var i = 0; i < fakes.length; i++) {
      list.add(GameItem(fakes[i], fake: fakes[(i + 1) % fakes.length]));
    }
    list.shuffle(service.random);
    store.dispatch(_UpdateItemsAction(list));
  }
}

class ResetItemsThunk
    extends CallableThunkActionWithExtraArgument<GlobalState, Assemble> {
  @override
  call(Store<GlobalState> store, Assemble service) {
    store.dispatch(UpdateCurrentAction(0));
    final countries = store.state.items.items.map((e) => e.original).toList();
    store.dispatch(UpdateItemsThunk(countries));
  }
}
