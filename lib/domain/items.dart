import 'dart:math';

import 'package:flutter_bloc/flutter_bloc.dart';

import 'models/country.dart';
import 'models/game_item.dart';
import 'states/items_state.dart';

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
