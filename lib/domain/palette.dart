import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:palette_generator/palette_generator.dart';

import 'models/color_pair.dart';

class PaletteState {
  static const _defaultColor = Colors.grey;

  static ColorPair _buildColors(PaletteGenerator? palette) {
    var mainColor = palette?.mutedColor?.color;
    var secondColor = palette?.vibrantColor?.color;
    final defaultColor = mainColor ?? secondColor ?? PaletteState._defaultColor;
    mainColor = mainColor ?? defaultColor;
    secondColor = secondColor ?? defaultColor;
    return ColorPair(mainColor, secondColor);
  }

  final PaletteGenerator? currentPalette;
  final PaletteGenerator? nextPalette;

  const PaletteState({
    this.currentPalette,
    this.nextPalette,
  });

  ColorPair get colors => currentPalette != null
      ? _buildColors(currentPalette)
      : const ColorPair(_defaultColor, _defaultColor);

  PaletteState copyWith({
    PaletteGenerator? currentPalette,
    PaletteGenerator? nextPalette,
  }) =>
      PaletteState(
        currentPalette: currentPalette ?? this.currentPalette,
        nextPalette: nextPalette ?? this.nextPalette,
      );
}

class PaletteLogic extends Cubit<PaletteState> {
  PaletteLogic() : super(const PaletteState());

  ColorPair get colors => state.colors;

  Future<void> updatePalette(ImageProvider current, ImageProvider? next) async {
    final crt = state.currentPalette == null
        ? await PaletteGenerator.fromImageProvider(current)
        : state.nextPalette;
    final nextGenerator =
        next != null ? await PaletteGenerator.fromImageProvider(next) : null;
    _updatePalettes(crt, nextGenerator);
  }

  void _updatePalettes(PaletteGenerator? current, PaletteGenerator? next) =>
      emit(state.copyWith(currentPalette: current, nextPalette: next));
}
