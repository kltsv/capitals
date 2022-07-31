// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target

part of 'game_item.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#custom-getters-and-methods');

GameItem _$GameItemFromJson(Map<String, dynamic> json) {
  return _GameItem.fromJson(json);
}

/// @nodoc
mixin _$GameItem {
  @JsonKey(name: 'original')
  Country get original => throw _privateConstructorUsedError;
  @JsonKey(name: 'fake')
  Country? get fake => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $GameItemCopyWith<GameItem> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $GameItemCopyWith<$Res> {
  factory $GameItemCopyWith(GameItem value, $Res Function(GameItem) then) =
      _$GameItemCopyWithImpl<$Res>;
  $Res call(
      {@JsonKey(name: 'original') Country original,
      @JsonKey(name: 'fake') Country? fake});

  $CountryCopyWith<$Res> get original;
  $CountryCopyWith<$Res>? get fake;
}

/// @nodoc
class _$GameItemCopyWithImpl<$Res> implements $GameItemCopyWith<$Res> {
  _$GameItemCopyWithImpl(this._value, this._then);

  final GameItem _value;
  // ignore: unused_field
  final $Res Function(GameItem) _then;

  @override
  $Res call({
    Object? original = freezed,
    Object? fake = freezed,
  }) {
    return _then(_value.copyWith(
      original: original == freezed
          ? _value.original
          : original // ignore: cast_nullable_to_non_nullable
              as Country,
      fake: fake == freezed
          ? _value.fake
          : fake // ignore: cast_nullable_to_non_nullable
              as Country?,
    ));
  }

  @override
  $CountryCopyWith<$Res> get original {
    return $CountryCopyWith<$Res>(_value.original, (value) {
      return _then(_value.copyWith(original: value));
    });
  }

  @override
  $CountryCopyWith<$Res>? get fake {
    if (_value.fake == null) {
      return null;
    }

    return $CountryCopyWith<$Res>(_value.fake!, (value) {
      return _then(_value.copyWith(fake: value));
    });
  }
}

/// @nodoc
abstract class _$$_GameItemCopyWith<$Res> implements $GameItemCopyWith<$Res> {
  factory _$$_GameItemCopyWith(
          _$_GameItem value, $Res Function(_$_GameItem) then) =
      __$$_GameItemCopyWithImpl<$Res>;
  @override
  $Res call(
      {@JsonKey(name: 'original') Country original,
      @JsonKey(name: 'fake') Country? fake});

  @override
  $CountryCopyWith<$Res> get original;
  @override
  $CountryCopyWith<$Res>? get fake;
}

/// @nodoc
class __$$_GameItemCopyWithImpl<$Res> extends _$GameItemCopyWithImpl<$Res>
    implements _$$_GameItemCopyWith<$Res> {
  __$$_GameItemCopyWithImpl(
      _$_GameItem _value, $Res Function(_$_GameItem) _then)
      : super(_value, (v) => _then(v as _$_GameItem));

  @override
  _$_GameItem get _value => super._value as _$_GameItem;

  @override
  $Res call({
    Object? original = freezed,
    Object? fake = freezed,
  }) {
    return _then(_$_GameItem(
      original == freezed
          ? _value.original
          : original // ignore: cast_nullable_to_non_nullable
              as Country,
      fake: fake == freezed
          ? _value.fake
          : fake // ignore: cast_nullable_to_non_nullable
              as Country?,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$_GameItem implements _GameItem {
  const _$_GameItem(@JsonKey(name: 'original') this.original,
      {@JsonKey(name: 'fake') this.fake});

  factory _$_GameItem.fromJson(Map<String, dynamic> json) =>
      _$$_GameItemFromJson(json);

  @override
  @JsonKey(name: 'original')
  final Country original;
  @override
  @JsonKey(name: 'fake')
  final Country? fake;

  @override
  String toString() {
    return 'GameItem(original: $original, fake: $fake)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$_GameItem &&
            const DeepCollectionEquality().equals(other.original, original) &&
            const DeepCollectionEquality().equals(other.fake, fake));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode => Object.hash(
      runtimeType,
      const DeepCollectionEquality().hash(original),
      const DeepCollectionEquality().hash(fake));

  @JsonKey(ignore: true)
  @override
  _$$_GameItemCopyWith<_$_GameItem> get copyWith =>
      __$$_GameItemCopyWithImpl<_$_GameItem>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$_GameItemToJson(
      this,
    );
  }
}

abstract class _GameItem implements GameItem {
  const factory _GameItem(@JsonKey(name: 'original') final Country original,
      {@JsonKey(name: 'fake') final Country? fake}) = _$_GameItem;

  factory _GameItem.fromJson(Map<String, dynamic> json) = _$_GameItem.fromJson;

  @override
  @JsonKey(name: 'original')
  Country get original;
  @override
  @JsonKey(name: 'fake')
  Country? get fake;
  @override
  @JsonKey(ignore: true)
  _$$_GameItemCopyWith<_$_GameItem> get copyWith =>
      throw _privateConstructorUsedError;
}
