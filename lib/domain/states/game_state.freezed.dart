// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target

part of 'game_state.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#custom-getters-and-methods');

GameState _$GameStateFromJson(Map<String, dynamic> json) {
  return _GameState.fromJson(json);
}

/// @nodoc
mixin _$GameState {
  @JsonKey(name: 'countries')
  List<Country> get countries => throw _privateConstructorUsedError;
  @JsonKey(name: 'score')
  int get score => throw _privateConstructorUsedError;
  @JsonKey(name: 'topScore')
  int get topScore => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $GameStateCopyWith<GameState> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $GameStateCopyWith<$Res> {
  factory $GameStateCopyWith(GameState value, $Res Function(GameState) then) =
      _$GameStateCopyWithImpl<$Res>;
  $Res call(
      {@JsonKey(name: 'countries') List<Country> countries,
      @JsonKey(name: 'score') int score,
      @JsonKey(name: 'topScore') int topScore});
}

/// @nodoc
class _$GameStateCopyWithImpl<$Res> implements $GameStateCopyWith<$Res> {
  _$GameStateCopyWithImpl(this._value, this._then);

  final GameState _value;
  // ignore: unused_field
  final $Res Function(GameState) _then;

  @override
  $Res call({
    Object? countries = freezed,
    Object? score = freezed,
    Object? topScore = freezed,
  }) {
    return _then(_value.copyWith(
      countries: countries == freezed
          ? _value.countries
          : countries // ignore: cast_nullable_to_non_nullable
              as List<Country>,
      score: score == freezed
          ? _value.score
          : score // ignore: cast_nullable_to_non_nullable
              as int,
      topScore: topScore == freezed
          ? _value.topScore
          : topScore // ignore: cast_nullable_to_non_nullable
              as int,
    ));
  }
}

/// @nodoc
abstract class _$$_GameStateCopyWith<$Res> implements $GameStateCopyWith<$Res> {
  factory _$$_GameStateCopyWith(
          _$_GameState value, $Res Function(_$_GameState) then) =
      __$$_GameStateCopyWithImpl<$Res>;
  @override
  $Res call(
      {@JsonKey(name: 'countries') List<Country> countries,
      @JsonKey(name: 'score') int score,
      @JsonKey(name: 'topScore') int topScore});
}

/// @nodoc
class __$$_GameStateCopyWithImpl<$Res> extends _$GameStateCopyWithImpl<$Res>
    implements _$$_GameStateCopyWith<$Res> {
  __$$_GameStateCopyWithImpl(
      _$_GameState _value, $Res Function(_$_GameState) _then)
      : super(_value, (v) => _then(v as _$_GameState));

  @override
  _$_GameState get _value => super._value as _$_GameState;

  @override
  $Res call({
    Object? countries = freezed,
    Object? score = freezed,
    Object? topScore = freezed,
  }) {
    return _then(_$_GameState(
      countries == freezed
          ? _value._countries
          : countries // ignore: cast_nullable_to_non_nullable
              as List<Country>,
      score == freezed
          ? _value.score
          : score // ignore: cast_nullable_to_non_nullable
              as int,
      topScore == freezed
          ? _value.topScore
          : topScore // ignore: cast_nullable_to_non_nullable
              as int,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$_GameState implements _GameState {
  const _$_GameState(
      @JsonKey(name: 'countries') final List<Country> countries,
      @JsonKey(name: 'score') this.score,
      @JsonKey(name: 'topScore') this.topScore)
      : _countries = countries;

  factory _$_GameState.fromJson(Map<String, dynamic> json) =>
      _$$_GameStateFromJson(json);

  final List<Country> _countries;
  @override
  @JsonKey(name: 'countries')
  List<Country> get countries {
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_countries);
  }

  @override
  @JsonKey(name: 'score')
  final int score;
  @override
  @JsonKey(name: 'topScore')
  final int topScore;

  @override
  String toString() {
    return 'GameState(countries: $countries, score: $score, topScore: $topScore)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$_GameState &&
            const DeepCollectionEquality()
                .equals(other._countries, _countries) &&
            const DeepCollectionEquality().equals(other.score, score) &&
            const DeepCollectionEquality().equals(other.topScore, topScore));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode => Object.hash(
      runtimeType,
      const DeepCollectionEquality().hash(_countries),
      const DeepCollectionEquality().hash(score),
      const DeepCollectionEquality().hash(topScore));

  @JsonKey(ignore: true)
  @override
  _$$_GameStateCopyWith<_$_GameState> get copyWith =>
      __$$_GameStateCopyWithImpl<_$_GameState>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$_GameStateToJson(
      this,
    );
  }
}

abstract class _GameState implements GameState {
  const factory _GameState(
      @JsonKey(name: 'countries') final List<Country> countries,
      @JsonKey(name: 'score') final int score,
      @JsonKey(name: 'topScore') final int topScore) = _$_GameState;

  factory _GameState.fromJson(Map<String, dynamic> json) =
      _$_GameState.fromJson;

  @override
  @JsonKey(name: 'countries')
  List<Country> get countries;
  @override
  @JsonKey(name: 'score')
  int get score;
  @override
  @JsonKey(name: 'topScore')
  int get topScore;
  @override
  @JsonKey(ignore: true)
  _$$_GameStateCopyWith<_$_GameState> get copyWith =>
      throw _privateConstructorUsedError;
}
