// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'items_state.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$_ItemsState _$$_ItemsStateFromJson(Map<String, dynamic> json) =>
    _$_ItemsState(
      json['currentIndex'] as int,
      (json['items'] as List<dynamic>)
          .map((e) => GameItem.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$$_ItemsStateToJson(_$_ItemsState instance) =>
    <String, dynamic>{
      'currentIndex': instance.currentIndex,
      'items': instance.items,
    };
