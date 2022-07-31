// ignore_for_file: invalid_annotation_target

import 'package:flutter/material.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

import 'country.dart';

part 'game_item.freezed.dart';
part 'game_item.g.dart';

@freezed
class GameItem with _$GameItem {
  const factory GameItem(
    @JsonKey(name: 'original') final Country original, {
    @JsonKey(name: 'fake') final Country? fake,
  }) = _GameItem;

  factory GameItem.fromJson(Map<String, dynamic> json) =>
      _$GameItemFromJson(json);
}

extension GameItemExt on GameItem {
  String get country => fake?.name ?? original.name;

  String get capital => fake?.capital ?? original.capital;

  ImageProvider get image => original.image;
}
