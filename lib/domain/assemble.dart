import 'dart:math';

import 'package:capitals/data/data.dart';
import 'package:capitals/domain/palette.dart';
import 'package:get_it/get_it.dart';
import 'package:injectable/injectable.dart';

import 'game.dart';
import 'items.dart';

import 'assemble.config.dart';

final getIt = GetIt.I;

@InjectableInit()
void setup() => $initGetIt(getIt);

@module
abstract class AssembleModule {
  @injectable
  Random provideRandom() => Random();

  @injectable
  Api providerApi() => Api();

  @lazySingleton
  Assets providerAssets() => Assets();

  @lazySingleton
  PaletteLogic providePaletteLogic() => PaletteLogic();

  @lazySingleton
  ItemsLogic provideItemsLogic(Random random) => ItemsLogic(random);

  @lazySingleton
  GameLogic provideGameLogic(Random random, Api api, Assets assets,
          PaletteLogic palette, ItemsLogic itemsLogic) =>
      GameLogic(random, api, assets, palette, itemsLogic);
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
