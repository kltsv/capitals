// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target

part of 'items_state.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#custom-getters-and-methods');

ItemsState _$ItemsStateFromJson(Map<String, dynamic> json) {
  return _ItemsState.fromJson(json);
}

/// @nodoc
mixin _$ItemsState {
  @JsonKey(name: 'currentIndex')
  int get currentIndex => throw _privateConstructorUsedError;
  @JsonKey(name: 'items')
  List<GameItem> get items => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $ItemsStateCopyWith<ItemsState> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $ItemsStateCopyWith<$Res> {
  factory $ItemsStateCopyWith(
          ItemsState value, $Res Function(ItemsState) then) =
      _$ItemsStateCopyWithImpl<$Res>;
  $Res call(
      {@JsonKey(name: 'currentIndex') int currentIndex,
      @JsonKey(name: 'items') List<GameItem> items});
}

/// @nodoc
class _$ItemsStateCopyWithImpl<$Res> implements $ItemsStateCopyWith<$Res> {
  _$ItemsStateCopyWithImpl(this._value, this._then);

  final ItemsState _value;
  // ignore: unused_field
  final $Res Function(ItemsState) _then;

  @override
  $Res call({
    Object? currentIndex = freezed,
    Object? items = freezed,
  }) {
    return _then(_value.copyWith(
      currentIndex: currentIndex == freezed
          ? _value.currentIndex
          : currentIndex // ignore: cast_nullable_to_non_nullable
              as int,
      items: items == freezed
          ? _value.items
          : items // ignore: cast_nullable_to_non_nullable
              as List<GameItem>,
    ));
  }
}

/// @nodoc
abstract class _$$_ItemsStateCopyWith<$Res>
    implements $ItemsStateCopyWith<$Res> {
  factory _$$_ItemsStateCopyWith(
          _$_ItemsState value, $Res Function(_$_ItemsState) then) =
      __$$_ItemsStateCopyWithImpl<$Res>;
  @override
  $Res call(
      {@JsonKey(name: 'currentIndex') int currentIndex,
      @JsonKey(name: 'items') List<GameItem> items});
}

/// @nodoc
class __$$_ItemsStateCopyWithImpl<$Res> extends _$ItemsStateCopyWithImpl<$Res>
    implements _$$_ItemsStateCopyWith<$Res> {
  __$$_ItemsStateCopyWithImpl(
      _$_ItemsState _value, $Res Function(_$_ItemsState) _then)
      : super(_value, (v) => _then(v as _$_ItemsState));

  @override
  _$_ItemsState get _value => super._value as _$_ItemsState;

  @override
  $Res call({
    Object? currentIndex = freezed,
    Object? items = freezed,
  }) {
    return _then(_$_ItemsState(
      currentIndex == freezed
          ? _value.currentIndex
          : currentIndex // ignore: cast_nullable_to_non_nullable
              as int,
      items == freezed
          ? _value._items
          : items // ignore: cast_nullable_to_non_nullable
              as List<GameItem>,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$_ItemsState implements _ItemsState {
  const _$_ItemsState(@JsonKey(name: 'currentIndex') this.currentIndex,
      @JsonKey(name: 'items') final List<GameItem> items)
      : _items = items;

  factory _$_ItemsState.fromJson(Map<String, dynamic> json) =>
      _$$_ItemsStateFromJson(json);

  @override
  @JsonKey(name: 'currentIndex')
  final int currentIndex;
  final List<GameItem> _items;
  @override
  @JsonKey(name: 'items')
  List<GameItem> get items {
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_items);
  }

  @override
  String toString() {
    return 'ItemsState(currentIndex: $currentIndex, items: $items)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$_ItemsState &&
            const DeepCollectionEquality()
                .equals(other.currentIndex, currentIndex) &&
            const DeepCollectionEquality().equals(other._items, _items));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode => Object.hash(
      runtimeType,
      const DeepCollectionEquality().hash(currentIndex),
      const DeepCollectionEquality().hash(_items));

  @JsonKey(ignore: true)
  @override
  _$$_ItemsStateCopyWith<_$_ItemsState> get copyWith =>
      __$$_ItemsStateCopyWithImpl<_$_ItemsState>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$_ItemsStateToJson(
      this,
    );
  }
}

abstract class _ItemsState implements ItemsState {
  const factory _ItemsState(
      @JsonKey(name: 'currentIndex') final int currentIndex,
      @JsonKey(name: 'items') final List<GameItem> items) = _$_ItemsState;

  factory _ItemsState.fromJson(Map<String, dynamic> json) =
      _$_ItemsState.fromJson;

  @override
  @JsonKey(name: 'currentIndex')
  int get currentIndex;
  @override
  @JsonKey(name: 'items')
  List<GameItem> get items;
  @override
  @JsonKey(ignore: true)
  _$$_ItemsStateCopyWith<_$_ItemsState> get copyWith =>
      throw _privateConstructorUsedError;
}
