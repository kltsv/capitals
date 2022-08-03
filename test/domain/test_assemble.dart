import 'dart:math';

import 'package:capitals/data/data.dart';
import 'package:capitals/domain/assemble.dart';
import 'package:injectable/injectable.dart';

import 'test_assemble.config.dart';

@InjectableInit(
  generateForDir: ['lib', 'test'],
)
void testSetup() => $initGetIt(getIt, environment: Environment.test);

@module
abstract class MockDataSourceModule {
  @test
  @injectable
  RandomGenerator provideRandomGenerator() => RandomGenerator(Random(0));
}
