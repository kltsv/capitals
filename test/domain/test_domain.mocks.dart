// Mocks generated by Mockito 5.3.0 from annotations
// in capitals/test/domain/test_domain.dart.
// Do not manually edit this file.

// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'dart:async' as _i4;
import 'dart:math' as _i2;

import 'package:capitals/data/data.dart' as _i3;
import 'package:capitals/domain/models/country.dart' as _i5;
import 'package:mockito/mockito.dart' as _i1;

// ignore_for_file: type=lint
// ignore_for_file: avoid_redundant_argument_values
// ignore_for_file: avoid_setters_without_getters
// ignore_for_file: comment_references
// ignore_for_file: implementation_imports
// ignore_for_file: invalid_use_of_visible_for_testing_member
// ignore_for_file: prefer_const_constructors
// ignore_for_file: unnecessary_parenthesis
// ignore_for_file: camel_case_types
// ignore_for_file: subtype_of_sealed_class

/// A class which mocks [Random].
///
/// See the documentation for Mockito's code generation for more information.
class MockRandom extends _i1.Mock implements _i2.Random {
  MockRandom() {
    _i1.throwOnMissingStub(this);
  }

  @override
  int nextInt(int? max) =>
      (super.noSuchMethod(Invocation.method(#nextInt, [max]), returnValue: 0)
          as int);
  @override
  double nextDouble() =>
      (super.noSuchMethod(Invocation.method(#nextDouble, []), returnValue: 0.0)
          as double);
  @override
  bool nextBool() =>
      (super.noSuchMethod(Invocation.method(#nextBool, []), returnValue: false)
          as bool);
}

/// A class which mocks [Api].
///
/// See the documentation for Mockito's code generation for more information.
class MockApi extends _i1.Mock implements _i3.Api {
  MockApi() {
    _i1.throwOnMissingStub(this);
  }

  @override
  _i4.Future<List<_i5.Country>> fetchCountries() =>
      (super.noSuchMethod(Invocation.method(#fetchCountries, []),
              returnValue: _i4.Future<List<_i5.Country>>.value(<_i5.Country>[]))
          as _i4.Future<List<_i5.Country>>);
}