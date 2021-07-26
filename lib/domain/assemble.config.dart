// GENERATED CODE - DO NOT MODIFY BY HAND

// **************************************************************************
// InjectableConfigGenerator
// **************************************************************************

import 'dart:math' as _i4;

import 'package:get_it/get_it.dart' as _i1;
import 'package:injectable/injectable.dart' as _i2;

import '../data/data.dart' as _i3;
import 'assemble.dart' as _i6;
import 'items.dart' as _i5; // ignore_for_file: unnecessary_lambdas

// ignore_for_file: lines_longer_than_80_chars
/// initializes the registration of provided dependencies inside of [GetIt]
_i1.GetIt $initGetIt(_i1.GetIt get,
    {String? environment, _i2.EnvironmentFilter? environmentFilter}) {
  final gh = _i2.GetItHelper(get, environment, environmentFilter);
  final assembleModule = _$AssembleModule();
  gh.factory<_i3.Api>(() => assembleModule.providerApi());
  gh.lazySingleton<_i3.Assets>(() => assembleModule.providerAssets());
  gh.factory<_i4.Random>(() => assembleModule.provideRandom());
  gh.lazySingleton<_i5.ItemsLogic>(
      () => assembleModule.provideItemsLogic(get<_i4.Random>()));
  return get;
}

class _$AssembleModule extends _i6.AssembleModule {}
