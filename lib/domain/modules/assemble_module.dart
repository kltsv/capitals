import 'package:capitals/data/data.dart';
import 'package:capitals/domain/palette.dart';
import 'package:injectable/injectable.dart';

import '../game.dart';
import '../items.dart';

@module
abstract class AssembleModule {
  @lazySingleton
  Assets provideAssets(JsonLoader loader) => Assets(loader);

  @lazySingleton
  PaletteLogic providePaletteLogic() => PaletteLogic();

  @lazySingleton
  ItemsLogic provideItemsLogic(RandomGenerator randomGenerator) =>
      ItemsLogic(randomGenerator.random);

  @lazySingleton
  GameLogic provideGameLogic(
    RandomGenerator randomGenerator,
    Api api,
    Assets assets,
    PaletteLogic palette,
    ItemsLogic itemsLogic,
  ) =>
      GameLogic(randomGenerator.random, api, assets, palette, itemsLogic);
}
