import 'package:capitals/domain/game.dart';
import 'package:capitals/domain/items.dart';
import 'package:capitals/domain/palette.dart';
import 'package:redux/redux.dart';

final globalStore =
    Store<GlobalState>(_globalReducer, initialState: GlobalState.initState);

GlobalState _globalReducer(GlobalState state, action) =>
    GlobalState(gameReducers(state.game, action), state.items, state.palette);

class GlobalState {
  static const initState =
      GlobalState(GameState.empty, ItemsState.empty, PaletteState.empty);

  final GameState game;
  final ItemsState items;
  final PaletteState palette;

  const GlobalState(this.game, this.items, this.palette);
}
