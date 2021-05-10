import 'package:flutter/cupertino.dart';

class Country {
  final String name;
  final String capital;
  final List<String> imageUrls;
  final int index;

  const Country(
    this.name,
    this.capital, {
    this.imageUrls = const [''],
    this.index = 0,
  });

  ImageProvider get image => NetworkImage('${imageUrls[index]}?w=600');
}

class GameItem {
  final Country original;
  final Country? fake;

  const GameItem(this.original, {this.fake});

  String get country => fake?.name ?? original.name;

  String get capital => fake?.capital ?? original.capital;

  ImageProvider get image => original.image;
}
