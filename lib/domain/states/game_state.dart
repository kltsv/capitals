// ignore_for_file: invalid_annotation_target
import 'dart:math';

import 'package:freezed_annotation/freezed_annotation.dart';

import '../models/country.dart';

part 'game_state.freezed.dart';
part 'game_state.g.dart';

@freezed
class GameState with _$GameState {
  static const GameState empty = GameState([], 0, 1);

  const factory GameState(
    @JsonKey(name: 'countries') final List<Country> countries,
    @JsonKey(name: 'score') final int score,
    @JsonKey(name: 'topScore') final int topScore,
  ) = _GameState;

  factory GameState.fromJson(Map<String, dynamic> json) =>
      _$GameStateFromJson(json);
}

extension GameStateExt on GameState {
  double get progress => max(0, score) / topScore;
}
