import 'package:capitals/data/data.dart';
import 'package:capitals/domain/assemble.dart';
import 'package:injectable/injectable.dart';

import 'game_test.dart';
import 'test_assemble.config.dart';
import 'test_domain.mocks.dart';

@InjectableInit(
  generateForDir: ['lib', 'test'],
)
void testSetup() => $initGetIt(getIt, environment: Environment.test);

@module
abstract class MockDataSourceModule {
  @test
  @injectable
  RandomGenerator provideRandomGenerator() => RandomGenerator(MockRandom());

  @test
  @injectable
  Api provideApi() => MockApi();

  @test
  @injectable
  JsonLoader provideJsonLoader() => const FileJsonLoader();
}
