import 'package:flutter/material.dart';
import 'package:palette_generator/palette_generator.dart';

import 'models.dart';

class PaletteState {
  final PaletteGenerator? currentPalette;
  final PaletteGenerator? nextPalette;

  const PaletteState({
    this.currentPalette,
    this.nextPalette,
  });

  PaletteState copyWith({
    PaletteGenerator? currentPalette,
    PaletteGenerator? nextPalette,
  }) =>
      PaletteState(
        currentPalette: currentPalette ?? this.currentPalette,
        nextPalette: nextPalette ?? this.nextPalette,
      );
}

class PaletteLogic extends ChangeNotifier {
  static const _defaultColor = Colors.grey;

  var state = PaletteState();

  ColorPair get colors => state.currentPalette != null
      ? _buildColors(state.currentPalette)
      : ColorPair(_defaultColor, _defaultColor);

  Future<void> updatePalette(ImageProvider current, ImageProvider? next) async {
    final crt = state.currentPalette == null
        ? await PaletteGenerator.fromImageProvider(current)
        : state.nextPalette;
    final _next =
        next != null ? await PaletteGenerator.fromImageProvider(next) : null;
    _setState(() => _updatePalettes(crt, _next));
  }

  void _updatePalettes(PaletteGenerator? current, PaletteGenerator? next) =>
      state = state.copyWith(currentPalette: current, nextPalette: next);

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
