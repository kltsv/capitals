import 'dart:math';

import 'package:capitals/data/data.dart';
import 'package:capitals/domain/palette.dart';

import 'game.dart';
import 'items.dart';

class Assemble {
  static final random = Random();
  static const api = Api();
  static final assets = Assets();
  static final palette = PaletteLogic();
  static late final itemsLogic = ItemsLogic(random);
  static late final game = GameLogic(random, api, assets, palette, itemsLogic);

  const Assemble._();
}
