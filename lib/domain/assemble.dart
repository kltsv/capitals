import 'dart:math';

import 'package:capitals/data/data.dart';
import 'package:get_it/get_it.dart';
import 'package:injectable/injectable.dart';

import 'assemble.config.dart';
import 'items.dart';

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
  ItemsLogic provideItemsLogic(Random random) => ItemsLogic(random);
}

class Assemble {
  Random get random => getIt.get<Random>();

  Api get api => getIt.get<Api>();

  Assets get assets => getIt.get<Assets>();

  ItemsLogic get itemsLogic => getIt.get<ItemsLogic>();

  const Assemble._();
}

const assemble = Assemble._();
