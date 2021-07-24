import 'dart:math';

import 'package:flutter/foundation.dart';

import 'models.dart';

class ItemsState {
  final int currentIndex;
  final List<GameItem> items;

  const ItemsState(this.currentIndex, this.items);

  ItemsState copyWith({
    int? currentIndex,
    List<GameItem>? items,
  }) =>
      ItemsState(
        currentIndex ?? this.currentIndex,
        items ?? this.items,
      );
}

class ItemsLogic extends ChangeNotifier {
  ItemsState state = ItemsState(0, []);

  final Random _random;

  ItemsLogic(this._random);

  GameItem get current => state.items[state.currentIndex];

  GameItem? get next => ((state.currentIndex + 1) < state.items.length)
      ? state.items[state.currentIndex + 1]
      : null;

  bool get isCompleted => state.currentIndex == state.items.length;

  bool get isCurrentTrue => current.fake == null;

  int get originalsLength =>
      state.items.where((element) => element.fake == null).length;

  int get fakeLength => state.items.length - originalsLength;

  double get progress => state.currentIndex / state.items.length;

  void updateCurrent(int current) =>
      _setState(() => state = state.copyWith(currentIndex: current));

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
    _setState(() {
      state = state.copyWith(items: list);
    });
  }

  void _setState(VoidCallback callback) {
    callback();
    notifyListeners();
  }
}
