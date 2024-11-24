// GENERATED CODE - DO NOT MODIFY BY HAND

// **************************************************************************
// InjectableConfigGenerator
// **************************************************************************

// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'package:get_it/get_it.dart' as _i1;
import 'package:injectable/injectable.dart' as _i2;

import '../data/data.dart' as _i3;
import 'game.dart' as _i6;
import 'items.dart' as _i5;
import 'modules/assemble_module.dart' as _i8;
import 'modules/data_source_module.dart' as _i7;
import 'palette.dart' as _i4;

const String _prod = 'prod';
// ignore_for_file: unnecessary_lambdas
// ignore_for_file: lines_longer_than_80_chars
/// initializes the registration of provided dependencies inside of [GetIt]
_i1.GetIt $initGetIt(
  _i1.GetIt get, {
  String? environment,
  _i2.EnvironmentFilter? environmentFilter,
}) {
  final gh = _i2.GetItHelper(
    get,
    environment,
    environmentFilter,
  );
  final dataSourceModule = _$DataSourceModule();
  final assembleModule = _$AssembleModule();
  gh.factory<_i3.Api>(() => dataSourceModule.provideApi());
  gh.factory<_i3.JsonLoader>(() => dataSourceModule.provideJsonLoader());
  gh.lazySingleton<_i4.PaletteLogic>(
      () => assembleModule.providePaletteLogic());
  gh.factory<_i3.RandomGenerator>(
    () => dataSourceModule.provideRandomGenerator(),
    registerFor: {_prod},
  );
  gh.lazySingleton<_i3.Assets>(
      () => assembleModule.provideAssets(get<_i3.JsonLoader>()));
  gh.lazySingleton<_i5.ItemsLogic>(
      () => assembleModule.provideItemsLogic(get<_i3.RandomGenerator>()));
  gh.lazySingleton<_i6.GameLogic>(() => assembleModule.provideGameLogic(
        get<_i3.RandomGenerator>(),
        get<_i3.Api>(),
        get<_i3.Assets>(),
        get<_i4.PaletteLogic>(),
        get<_i5.ItemsLogic>(),
      ));
  return get;
}

class _$DataSourceModule extends _i7.DataSourceModule {}

class _$AssembleModule extends _i8.AssembleModule {}
