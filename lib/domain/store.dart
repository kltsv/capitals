import 'package:capitals/domain/assemble.dart';
import 'package:capitals/domain/game.dart';
import 'package:capitals/domain/items.dart';
import 'package:capitals/domain/palette.dart';
import 'package:redux/redux.dart';
import 'package:redux_thunk/redux_thunk.dart';

final globalStore = Store<GlobalState>(_globalReducer,
    initialState: GlobalState.initState,
    middleware: [ExtraArgumentThunkMiddleware(Assemble())]);

GlobalState _globalReducer(GlobalState state, action) => GlobalState(
      gameReducers(state.game, action),
      itemsReducers(state.items, action),
      paletteReducers(state.palette, action),
    );

class GlobalState {
  static const initState =
      GlobalState(GameState.empty, ItemsState.empty, PaletteState.empty);

  final GameState game;
  final ItemsState items;
  final PaletteState palette;

  const GlobalState(this.game, this.items, this.palette);
}
