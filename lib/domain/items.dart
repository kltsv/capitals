import 'dart:math';

import 'package:flutter_bloc/flutter_bloc.dart';

import 'models.dart';

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

class ItemsLogic extends Cubit<ItemsState> {
  final Random _random;

  ItemsLogic(this._random) : super(ItemsState.empty);

  void updateCurrent(int current) =>
      emit(state.copyWith(currentIndex: current));

  void reset() {
    updateCurrent(0);
    final countries = state.items.map((e) => e.original).toList();
    updateItems(countries);
  }

  void updateItems(List<Country> countries) {
    final originals = countries.sublist(0, countries.length ~/ 2);
    final fakes = countries.sublist(countries.length ~/ 2, countries.length);
    fakes.shuffle(_random);
    final list = <GameItem>[];
    list.addAll(originals.map((e) => GameItem(e)));
    for (var i = 0; i < fakes.length; i++) {
      list.add(GameItem(fakes[i], fake: fakes[(i + 1) % fakes.length]));
    }
    list.shuffle(_random);
    emit(state.copyWith(items: list));
  }
}
