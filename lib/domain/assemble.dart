import 'dart:math';

import 'package:capitals/data/data.dart';
import 'package:capitals/domain/palette.dart';
import 'package:yx_scope/yx_scope.dart';

import 'game.dart';
import 'items.dart';

/// Интерфейс для доступа к зависимостям приложения
abstract class AppScope implements Scope {
  Random get random;
  Api get api;
  Assets get assets;
  PaletteLogic get palette;
  ItemsLogic get itemsLogic;
  GameLogic get game;
}

/// Модуль для управления источниками данных
class DataSourcesScopeModule extends ScopeModule<AppScopeContainer> {
  DataSourcesScopeModule(AppScopeContainer container) : super(container);

  late final randomGeneratorDep = dep(() => RandomGenerator());
  late final apiDep = dep(() => const Api());
  late final jsonLoaderDep = dep(() => const AssetsJsonLoader());
}

/// Модуль для управления ресурсами и ассетами
class AssetsScopeModule extends ScopeModule<AppScopeContainer> {
  AssetsScopeModule(AppScopeContainer container) : super(container);

  late final assetsDep = dep(() => Assets(
        container.dataSourcesModule.jsonLoaderDep.get,
      ));
}

/// Модуль для управления бизнес-логикой
class BusinessLogicScopeModule extends ScopeModule<AppScopeContainer> {
  BusinessLogicScopeModule(AppScopeContainer container) : super(container);

  late final paletteLogicDep = dep(() => PaletteLogic());

  late final itemsLogicDep = dep(() => ItemsLogic(
        container.dataSourcesModule.randomGeneratorDep.get.random,
      ));
}

/// Модуль для управления игровой логикой
class GameScopeModule extends ScopeModule<AppScopeContainer> {
  GameScopeModule(AppScopeContainer container) : super(container);

  late final gameLogicDep = dep(() => GameLogic(
        container.dataSourcesModule.randomGeneratorDep.get.random,
        container.dataSourcesModule.apiDep.get,
        container.assetsModule.assetsDep.get,
        container.businessLogicModule.paletteLogicDep.get,
        container.businessLogicModule.itemsLogicDep.get,
      ));
}

/// Основной контейнер приложения с модульной архитектурой
class AppScopeContainer extends ScopeContainer implements AppScope {
  // Модули для логической группировки зависимостей
  late final dataSourcesModule = DataSourcesScopeModule(this);
  late final assetsModule = AssetsScopeModule(this);
  late final businessLogicModule = BusinessLogicScopeModule(this);
  late final gameModule = GameScopeModule(this);

  // Реализация интерфейса AppScope
  @override
  Random get random => dataSourcesModule.randomGeneratorDep.get.random;

  @override
  Api get api => dataSourcesModule.apiDep.get;

  @override
  Assets get assets => assetsModule.assetsDep.get;

  @override
  PaletteLogic get palette => businessLogicModule.paletteLogicDep.get;

  @override
  ItemsLogic get itemsLogic => businessLogicModule.itemsLogicDep.get;

  @override
  GameLogic get game => gameModule.gameLogicDep.get;
}

class AppScopeHolder extends ScopeHolder<AppScopeContainer> {
  @override
  AppScopeContainer createContainer() => AppScopeContainer();

  // Геттер для работы с интерфейсом
  AppScope? get appScope => scope;
}

final appScopeHolder = AppScopeHolder();
