// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'game_item.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

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
      _$GameItemCopyWithImpl<$Res, GameItem>;
  @useResult
  $Res call(
      {@JsonKey(name: 'original') Country original,
      @JsonKey(name: 'fake') Country? fake});

  $CountryCopyWith<$Res> get original;
  $CountryCopyWith<$Res>? get fake;
}

/// @nodoc
class _$GameItemCopyWithImpl<$Res, $Val extends GameItem>
    implements $GameItemCopyWith<$Res> {
  _$GameItemCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? original = null,
    Object? fake = freezed,
  }) {
    return _then(_value.copyWith(
      original: null == original
          ? _value.original
          : original // ignore: cast_nullable_to_non_nullable
              as Country,
      fake: freezed == fake
          ? _value.fake
          : fake // ignore: cast_nullable_to_non_nullable
              as Country?,
    ) as $Val);
  }

  @override
  @pragma('vm:prefer-inline')
  $CountryCopyWith<$Res> get original {
    return $CountryCopyWith<$Res>(_value.original, (value) {
      return _then(_value.copyWith(original: value) as $Val);
    });
  }

  @override
  @pragma('vm:prefer-inline')
  $CountryCopyWith<$Res>? get fake {
    if (_value.fake == null) {
      return null;
    }

    return $CountryCopyWith<$Res>(_value.fake!, (value) {
      return _then(_value.copyWith(fake: value) as $Val);
    });
  }
}

/// @nodoc
abstract class _$$GameItemImplCopyWith<$Res>
    implements $GameItemCopyWith<$Res> {
  factory _$$GameItemImplCopyWith(
          _$GameItemImpl value, $Res Function(_$GameItemImpl) then) =
      __$$GameItemImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {@JsonKey(name: 'original') Country original,
      @JsonKey(name: 'fake') Country? fake});

  @override
  $CountryCopyWith<$Res> get original;
  @override
  $CountryCopyWith<$Res>? get fake;
}

/// @nodoc
class __$$GameItemImplCopyWithImpl<$Res>
    extends _$GameItemCopyWithImpl<$Res, _$GameItemImpl>
    implements _$$GameItemImplCopyWith<$Res> {
  __$$GameItemImplCopyWithImpl(
      _$GameItemImpl _value, $Res Function(_$GameItemImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? original = null,
    Object? fake = freezed,
  }) {
    return _then(_$GameItemImpl(
      null == original
          ? _value.original
          : original // ignore: cast_nullable_to_non_nullable
              as Country,
      fake: freezed == fake
          ? _value.fake
          : fake // ignore: cast_nullable_to_non_nullable
              as Country?,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$GameItemImpl implements _GameItem {
  const _$GameItemImpl(@JsonKey(name: 'original') this.original,
      {@JsonKey(name: 'fake') this.fake});

  factory _$GameItemImpl.fromJson(Map<String, dynamic> json) =>
      _$$GameItemImplFromJson(json);

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
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$GameItemImpl &&
            (identical(other.original, original) ||
                other.original == original) &&
            (identical(other.fake, fake) || other.fake == fake));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode => Object.hash(runtimeType, original, fake);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$GameItemImplCopyWith<_$GameItemImpl> get copyWith =>
      __$$GameItemImplCopyWithImpl<_$GameItemImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$GameItemImplToJson(
      this,
    );
  }
}

abstract class _GameItem implements GameItem {
  const factory _GameItem(@JsonKey(name: 'original') final Country original,
      {@JsonKey(name: 'fake') final Country? fake}) = _$GameItemImpl;

  factory _GameItem.fromJson(Map<String, dynamic> json) =
      _$GameItemImpl.fromJson;

  @override
  @JsonKey(name: 'original')
  Country get original;
  @override
  @JsonKey(name: 'fake')
  Country? get fake;
  @override
  @JsonKey(ignore: true)
  _$$GameItemImplCopyWith<_$GameItemImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
