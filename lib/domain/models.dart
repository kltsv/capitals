import 'package:flutter/widgets.dart';

class Country {
  /// Название страны
  final String name;

  /// Название столицы
  final String capital;

  /// Список ссылок на картинки со страной
  final List<String> imageUrls;

  /// Индекс картинки, которую нужно показать
  final int index;

  const Country(
    this.name,
    this.capital, {
    this.imageUrls = const [''],
    this.index = 0,
  });

  ImageProvider get image => NetworkImage('${imageUrls[index]}?w=600');

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is Country &&
          runtimeType == other.runtimeType &&
          name == other.name &&
          capital == other.capital &&
          imageUrls == other.imageUrls &&
          index == other.index;

  @override
  int get hashCode =>
      name.hashCode ^ capital.hashCode ^ imageUrls.hashCode ^ index.hashCode;

  @override
  String toString() => '$name-$capital';
}

class GameItem {
  final Country original;
  final Country? fake;

  const GameItem(this.original, {this.fake});

  String get country => fake?.name ?? original.name;

  String get capital => fake?.capital ?? original.capital;

  ImageProvider get image => original.image;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is GameItem &&
          runtimeType == other.runtimeType &&
          original == other.original &&
          fake == other.fake;

  @override
  int get hashCode => original.hashCode ^ fake.hashCode;

  @override
  String toString() => '$original${fake != null ? ' (fake: $fake)' : ''}';
}

class ColorPair {
  final Color main;
  final Color second;

  const ColorPair(this.main, this.second);
}
