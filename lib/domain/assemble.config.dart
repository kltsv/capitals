// GENERATED CODE - DO NOT MODIFY BY HAND

// **************************************************************************
// InjectableConfigGenerator
// **************************************************************************

import 'dart:math' as _i5;

import 'package:get_it/get_it.dart' as _i1;
import 'package:injectable/injectable.dart' as _i2;

import '../data/data.dart' as _i3;
import 'assemble.dart' as _i8;
import 'game.dart' as _i7;
import 'items.dart' as _i6;
import 'palette.dart' as _i4; // ignore_for_file: unnecessary_lambdas

// ignore_for_file: lines_longer_than_80_chars
/// initializes the registration of provided dependencies inside of [GetIt]
_i1.GetIt $initGetIt(_i1.GetIt get,
    {String? environment, _i2.EnvironmentFilter? environmentFilter}) {
  final gh = _i2.GetItHelper(get, environment, environmentFilter);
  final assembleModule = _$AssembleModule();
  gh.factory<_i3.Api>(() => assembleModule.providerApi());
  gh.lazySingleton<_i3.Assets>(() => assembleModule.providerAssets());
  gh.lazySingleton<_i4.PaletteLogic>(
      () => assembleModule.providePaletteLogic());
  gh.factory<_i5.Random>(() => assembleModule.provideRandom());
  gh.lazySingleton<_i6.ItemsLogic>(
      () => assembleModule.provideItemsLogic(get<_i5.Random>()));
  gh.lazySingleton<_i7.GameLogic>(() => assembleModule.provideGameLogic(
      get<_i5.Random>(),
      get<_i3.Api>(),
      get<_i3.Assets>(),
      get<_i4.PaletteLogic>(),
      get<_i6.ItemsLogic>()));
  return get;
}

class _$AssembleModule extends _i8.AssembleModule {}
