import 'package:capitals/data/data.dart';
import 'package:injectable/injectable.dart';

@module
abstract class DataSourceModule {
  @prod
  @injectable
  RandomGenerator provideRandomGenerator() => RandomGenerator();

  @prod
  @injectable
  Api provideApi() => const Api();

  @prod
  @injectable
  JsonLoader provideJsonLoader() => const AssetsJsonLoader();
}
