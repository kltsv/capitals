// ignore_for_file: invalid_annotation_target
import 'package:freezed_annotation/freezed_annotation.dart';

import '../models/game_item.dart';

part 'items_state.freezed.dart';
part 'items_state.g.dart';

@freezed
class ItemsState with _$ItemsState {
  static const empty = ItemsState(0, []);

  const factory ItemsState(
    @JsonKey(name: 'currentIndex') final int currentIndex,
    @JsonKey(name: 'items') final List<GameItem> items,
  ) = _ItemsState;

  factory ItemsState.fromJson(Map<String, dynamic> json) =>
      _$ItemsStateFromJson(json);
}

extension ItemsStateExt on ItemsState {
  GameItem get current => items[currentIndex];

  GameItem? get next =>
      ((currentIndex + 1) < items.length) ? items[currentIndex + 1] : null;

  // Игра считается завершенной, когда индекс
  // становится больше индекса последнего элемента
  bool get isCompleted => items.isNotEmpty && currentIndex == items.length;

  bool get isEmpty => items.isEmpty;

  bool get isCurrentTrue => current.fake == null;

  int get originalsLength =>
      items.where((element) => element.fake == null).length;

  int get fakeLength => items.length - originalsLength;

  double get progress => isEmpty ? 0 : currentIndex / items.length;
}
