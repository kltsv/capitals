import 'package:capitals/data/data.dart';
import 'package:injectable/injectable.dart';

@module
abstract class DataSourceModule {
  @prod
  @injectable
  RandomGenerator provideRandomGenerator() => RandomGenerator();

  @injectable
  Api provideApi() => const Api();

  @injectable
  JsonLoader provideJsonLoader() => const AssetsJsonLoader();
}
