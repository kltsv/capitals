// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target

part of 'country.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#custom-getters-and-methods');

Country _$CountryFromJson(Map<String, dynamic> json) {
  return _Country.fromJson(json);
}

/// @nodoc
mixin _$Country {
  /// Название страны
  @JsonKey(name: 'name')
  String get name => throw _privateConstructorUsedError;

  /// Название столицы
  @JsonKey(name: 'capital')
  String get capital => throw _privateConstructorUsedError;

  /// Список ссылок на картинки со страной
  @JsonKey(name: 'imageUrls')
  List<String> get imageUrls => throw _privateConstructorUsedError;

  /// Индекс картинки, которую нужно показать
  @JsonKey(name: 'index')
  int get index => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $CountryCopyWith<Country> get copyWith => throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $CountryCopyWith<$Res> {
  factory $CountryCopyWith(Country value, $Res Function(Country) then) =
      _$CountryCopyWithImpl<$Res>;
  $Res call(
      {@JsonKey(name: 'name') String name,
      @JsonKey(name: 'capital') String capital,
      @JsonKey(name: 'imageUrls') List<String> imageUrls,
      @JsonKey(name: 'index') int index});
}

/// @nodoc
class _$CountryCopyWithImpl<$Res> implements $CountryCopyWith<$Res> {
  _$CountryCopyWithImpl(this._value, this._then);

  final Country _value;
  // ignore: unused_field
  final $Res Function(Country) _then;

  @override
  $Res call({
    Object? name = freezed,
    Object? capital = freezed,
    Object? imageUrls = freezed,
    Object? index = freezed,
  }) {
    return _then(_value.copyWith(
      name: name == freezed
          ? _value.name
          : name // ignore: cast_nullable_to_non_nullable
              as String,
      capital: capital == freezed
          ? _value.capital
          : capital // ignore: cast_nullable_to_non_nullable
              as String,
      imageUrls: imageUrls == freezed
          ? _value.imageUrls
          : imageUrls // ignore: cast_nullable_to_non_nullable
              as List<String>,
      index: index == freezed
          ? _value.index
          : index // ignore: cast_nullable_to_non_nullable
              as int,
    ));
  }
}

/// @nodoc
abstract class _$$_CountryCopyWith<$Res> implements $CountryCopyWith<$Res> {
  factory _$$_CountryCopyWith(
          _$_Country value, $Res Function(_$_Country) then) =
      __$$_CountryCopyWithImpl<$Res>;
  @override
  $Res call(
      {@JsonKey(name: 'name') String name,
      @JsonKey(name: 'capital') String capital,
      @JsonKey(name: 'imageUrls') List<String> imageUrls,
      @JsonKey(name: 'index') int index});
}

/// @nodoc
class __$$_CountryCopyWithImpl<$Res> extends _$CountryCopyWithImpl<$Res>
    implements _$$_CountryCopyWith<$Res> {
  __$$_CountryCopyWithImpl(_$_Country _value, $Res Function(_$_Country) _then)
      : super(_value, (v) => _then(v as _$_Country));

  @override
  _$_Country get _value => super._value as _$_Country;

  @override
  $Res call({
    Object? name = freezed,
    Object? capital = freezed,
    Object? imageUrls = freezed,
    Object? index = freezed,
  }) {
    return _then(_$_Country(
      name == freezed
          ? _value.name
          : name // ignore: cast_nullable_to_non_nullable
              as String,
      capital == freezed
          ? _value.capital
          : capital // ignore: cast_nullable_to_non_nullable
              as String,
      imageUrls: imageUrls == freezed
          ? _value._imageUrls
          : imageUrls // ignore: cast_nullable_to_non_nullable
              as List<String>,
      index: index == freezed
          ? _value.index
          : index // ignore: cast_nullable_to_non_nullable
              as int,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$_Country implements _Country {
  const _$_Country(
      @JsonKey(name: 'name')
          this.name,
      @JsonKey(name: 'capital')
          this.capital,
      {@JsonKey(name: 'imageUrls')
          final List<String> imageUrls = const <String>[],
      @JsonKey(name: 'index')
          this.index = 0})
      : _imageUrls = imageUrls;

  factory _$_Country.fromJson(Map<String, dynamic> json) =>
      _$$_CountryFromJson(json);

  /// Название страны
  @override
  @JsonKey(name: 'name')
  final String name;

  /// Название столицы
  @override
  @JsonKey(name: 'capital')
  final String capital;

  /// Список ссылок на картинки со страной
  final List<String> _imageUrls;

  /// Список ссылок на картинки со страной
  @override
  @JsonKey(name: 'imageUrls')
  List<String> get imageUrls {
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_imageUrls);
  }

  /// Индекс картинки, которую нужно показать
  @override
  @JsonKey(name: 'index')
  final int index;

  @override
  String toString() {
    return 'Country(name: $name, capital: $capital, imageUrls: $imageUrls, index: $index)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$_Country &&
            const DeepCollectionEquality().equals(other.name, name) &&
            const DeepCollectionEquality().equals(other.capital, capital) &&
            const DeepCollectionEquality()
                .equals(other._imageUrls, _imageUrls) &&
            const DeepCollectionEquality().equals(other.index, index));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode => Object.hash(
      runtimeType,
      const DeepCollectionEquality().hash(name),
      const DeepCollectionEquality().hash(capital),
      const DeepCollectionEquality().hash(_imageUrls),
      const DeepCollectionEquality().hash(index));

  @JsonKey(ignore: true)
  @override
  _$$_CountryCopyWith<_$_Country> get copyWith =>
      __$$_CountryCopyWithImpl<_$_Country>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$_CountryToJson(
      this,
    );
  }
}

abstract class _Country implements Country {
  const factory _Country(@JsonKey(name: 'name') final String name,
      @JsonKey(name: 'capital') final String capital,
      {@JsonKey(name: 'imageUrls') final List<String> imageUrls,
      @JsonKey(name: 'index') final int index}) = _$_Country;

  factory _Country.fromJson(Map<String, dynamic> json) = _$_Country.fromJson;

  @override

  /// Название страны
  @JsonKey(name: 'name')
  String get name;
  @override

  /// Название столицы
  @JsonKey(name: 'capital')
  String get capital;
  @override

  /// Список ссылок на картинки со страной
  @JsonKey(name: 'imageUrls')
  List<String> get imageUrls;
  @override

  /// Индекс картинки, которую нужно показать
  @JsonKey(name: 'index')
  int get index;
  @override
  @JsonKey(ignore: true)
  _$$_CountryCopyWith<_$_Country> get copyWith =>
      throw _privateConstructorUsedError;
}
