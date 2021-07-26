import 'package:capitals/domain/store.dart';
import 'package:flutter/material.dart';
import 'package:palette_generator/palette_generator.dart';
import 'package:redux/redux.dart';
import 'package:redux_thunk/redux_thunk.dart';

import 'assemble.dart';
import 'models.dart';

class PaletteState {
  static const empty = PaletteState();

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

final paletteReducers = combineReducers<PaletteState>([
  TypedReducer<PaletteState, _UpdatePaletteAction>(_updatePalette),
]);

class _UpdatePaletteAction {
  final PaletteGenerator? current;
  final PaletteGenerator? next;

  const _UpdatePaletteAction(this.current, this.next);
}

PaletteState _updatePalette(PaletteState state, _UpdatePaletteAction action) =>
    state.copyWith(currentPalette: action.current, nextPalette: action.next);

class UpdatePaletteThunk
    extends CallableThunkActionWithExtraArgument<GlobalState, Assemble> {
  final ImageProvider current;
  final ImageProvider? next;

  UpdatePaletteThunk(this.current, this.next);

  @override
  call(Store<GlobalState> store, Assemble service) async {
    final state = store.state.palette;
    final crt = state.currentPalette == null
        ? await PaletteGenerator.fromImageProvider(current)
        : state.nextPalette;
    final nextProvider = next;
    final _next = nextProvider != null
        ? await PaletteGenerator.fromImageProvider(nextProvider)
        : null;

    store.dispatch(_UpdatePaletteAction(crt, _next));
  }
}
