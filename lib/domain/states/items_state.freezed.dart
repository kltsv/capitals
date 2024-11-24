// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'items_state.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

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
      _$ItemsStateCopyWithImpl<$Res, ItemsState>;
  @useResult
  $Res call(
      {@JsonKey(name: 'currentIndex') int currentIndex,
      @JsonKey(name: 'items') List<GameItem> items});
}

/// @nodoc
class _$ItemsStateCopyWithImpl<$Res, $Val extends ItemsState>
    implements $ItemsStateCopyWith<$Res> {
  _$ItemsStateCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? currentIndex = null,
    Object? items = null,
  }) {
    return _then(_value.copyWith(
      currentIndex: null == currentIndex
          ? _value.currentIndex
          : currentIndex // ignore: cast_nullable_to_non_nullable
              as int,
      items: null == items
          ? _value.items
          : items // ignore: cast_nullable_to_non_nullable
              as List<GameItem>,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$ItemsStateImplCopyWith<$Res>
    implements $ItemsStateCopyWith<$Res> {
  factory _$$ItemsStateImplCopyWith(
          _$ItemsStateImpl value, $Res Function(_$ItemsStateImpl) then) =
      __$$ItemsStateImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {@JsonKey(name: 'currentIndex') int currentIndex,
      @JsonKey(name: 'items') List<GameItem> items});
}

/// @nodoc
class __$$ItemsStateImplCopyWithImpl<$Res>
    extends _$ItemsStateCopyWithImpl<$Res, _$ItemsStateImpl>
    implements _$$ItemsStateImplCopyWith<$Res> {
  __$$ItemsStateImplCopyWithImpl(
      _$ItemsStateImpl _value, $Res Function(_$ItemsStateImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? currentIndex = null,
    Object? items = null,
  }) {
    return _then(_$ItemsStateImpl(
      null == currentIndex
          ? _value.currentIndex
          : currentIndex // ignore: cast_nullable_to_non_nullable
              as int,
      null == items
          ? _value._items
          : items // ignore: cast_nullable_to_non_nullable
              as List<GameItem>,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$ItemsStateImpl implements _ItemsState {
  const _$ItemsStateImpl(@JsonKey(name: 'currentIndex') this.currentIndex,
      @JsonKey(name: 'items') final List<GameItem> items)
      : _items = items;

  factory _$ItemsStateImpl.fromJson(Map<String, dynamic> json) =>
      _$$ItemsStateImplFromJson(json);

  @override
  @JsonKey(name: 'currentIndex')
  final int currentIndex;
  final List<GameItem> _items;
  @override
  @JsonKey(name: 'items')
  List<GameItem> get items {
    if (_items is EqualUnmodifiableListView) return _items;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_items);
  }

  @override
  String toString() {
    return 'ItemsState(currentIndex: $currentIndex, items: $items)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$ItemsStateImpl &&
            (identical(other.currentIndex, currentIndex) ||
                other.currentIndex == currentIndex) &&
            const DeepCollectionEquality().equals(other._items, _items));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode => Object.hash(
      runtimeType, currentIndex, const DeepCollectionEquality().hash(_items));

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$ItemsStateImplCopyWith<_$ItemsStateImpl> get copyWith =>
      __$$ItemsStateImplCopyWithImpl<_$ItemsStateImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$ItemsStateImplToJson(
      this,
    );
  }
}

abstract class _ItemsState implements ItemsState {
  const factory _ItemsState(
      @JsonKey(name: 'currentIndex') final int currentIndex,
      @JsonKey(name: 'items') final List<GameItem> items) = _$ItemsStateImpl;

  factory _ItemsState.fromJson(Map<String, dynamic> json) =
      _$ItemsStateImpl.fromJson;

  @override
  @JsonKey(name: 'currentIndex')
  int get currentIndex;
  @override
  @JsonKey(name: 'items')
  List<GameItem> get items;
  @override
  @JsonKey(ignore: true)
  _$$ItemsStateImplCopyWith<_$ItemsStateImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
