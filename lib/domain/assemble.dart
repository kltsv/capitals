import 'dart:math';

import 'package:capitals/data/data.dart';
import 'package:capitals/domain/palette.dart';
import 'package:get_it/get_it.dart';

import 'game.dart';
import 'items.dart';

final getIt = GetIt.I;

void setup() {
  getIt.registerFactory(() => Random());
  getIt.registerFactory(() => Api());
  getIt.registerLazySingleton(() => Assets());
  getIt.registerLazySingleton(() => PaletteLogic());
  getIt.registerLazySingleton(() => ItemsLogic(getIt.get<Random>()));
  getIt.registerLazySingleton(
    () => GameLogic(getIt.get<Random>(), getIt.get<Api>(), getIt.get<Assets>(),
        getIt.get<PaletteLogic>(), getIt.get<ItemsLogic>()),
  );
}

class Assemble {
  Random get random => getIt.get<Random>();

  Api get api => getIt.get<Api>();

  Assets get assets => getIt.get<Assets>();

  PaletteLogic get palette => getIt.get<PaletteLogic>();

  ItemsLogic get itemsLogic => getIt.get<ItemsLogic>();

  GameLogic get game => getIt.get<GameLogic>();

  const Assemble._();
}

const assemble = Assemble._();
