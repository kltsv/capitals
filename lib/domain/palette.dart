import 'package:flutter/material.dart';
import 'package:palette_generator/palette_generator.dart';

import 'models.dart';

class PaletteLogic extends ChangeNotifier {
  PaletteGenerator? currentPalette;
  PaletteGenerator? nextPalette;

  ColorPair colors = ColorPair(Colors.grey, Colors.grey);

  Future<void> updatePalette(ImageProvider current, ImageProvider? next) async {
    final crt = currentPalette == null
        ? await PaletteGenerator.fromImageProvider(current)
        : nextPalette;
    final _next =
        next != null ? await PaletteGenerator.fromImageProvider(next) : null;
    _setState(() {
      currentPalette = crt;
      nextPalette = _next;
      colors = _buildColors(crt);
    });
  }

  ColorPair _buildColors(PaletteGenerator? palette) {
    var mainColor = palette?.mutedColor?.color;
    var secondColor = palette?.vibrantColor?.color;
    final defaultColor = mainColor ?? secondColor ?? Colors.grey;
    mainColor = mainColor ?? defaultColor;
    secondColor = secondColor ?? defaultColor;
    return ColorPair(mainColor, secondColor);
  }

  void _setState(VoidCallback callback) {
    callback();
    notifyListeners();
  }
}
