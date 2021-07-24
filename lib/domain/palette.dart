import 'package:flutter/material.dart';
import 'package:palette_generator/palette_generator.dart';

import 'models.dart';

class PaletteLogic extends ChangeNotifier {
  static const _defaultColor = Colors.grey;

  PaletteGenerator? _currentPalette;
  PaletteGenerator? _nextPalette;

  ColorPair get colors => _currentPalette != null
      ? _buildColors(_currentPalette)
      : ColorPair(_defaultColor, _defaultColor);

  Future<void> updatePalette(ImageProvider current, ImageProvider? next) async {
    final crt = _currentPalette == null
        ? await PaletteGenerator.fromImageProvider(current)
        : _nextPalette;
    final _next =
        next != null ? await PaletteGenerator.fromImageProvider(next) : null;
    _setState(() {
      _currentPalette = crt;
      _nextPalette = _next;
    });
  }

  ColorPair _buildColors(PaletteGenerator? palette) {
    var mainColor = palette?.mutedColor?.color;
    var secondColor = palette?.vibrantColor?.color;
    final defaultColor = mainColor ?? secondColor ?? _defaultColor;
    mainColor = mainColor ?? defaultColor;
    secondColor = secondColor ?? defaultColor;
    return ColorPair(mainColor, secondColor);
  }

  void _setState(VoidCallback callback) {
    callback();
    notifyListeners();
  }
}
