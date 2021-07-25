import 'dart:async';

import 'package:flutter/material.dart';
import 'package:palette_generator/palette_generator.dart';

import 'models.dart';

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
      : ColorPair(_defaultColor, _defaultColor);

  PaletteState copyWith({
    PaletteGenerator? currentPalette,
    PaletteGenerator? nextPalette,
  }) =>
      PaletteState(
        currentPalette: currentPalette ?? this.currentPalette,
        nextPalette: nextPalette ?? this.nextPalette,
      );
}

class PaletteLogic {
  final _controller = StreamController<PaletteState>.broadcast();
  var _state = PaletteState();

  Stream<ColorPair> get stream =>
      _controller.stream.map((state) => state.colors);

  ColorPair get colors => _state.colors;

  Future<void> dispose() => _controller.close();

  Future<void> updatePalette(ImageProvider current, ImageProvider? next) async {
    final crt = _state.currentPalette == null
        ? await PaletteGenerator.fromImageProvider(current)
        : _state.nextPalette;
    final _next =
        next != null ? await PaletteGenerator.fromImageProvider(next) : null;
    _updatePalettes(crt, _next);
  }

  void _updatePalettes(PaletteGenerator? current, PaletteGenerator? next) =>
      _setState(_state.copyWith(currentPalette: current, nextPalette: next));

  void _setState(PaletteState state) {
    _state = state;
    _controller.add(_state);
  }
}
