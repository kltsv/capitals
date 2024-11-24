// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'items_state.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$ItemsStateImpl _$$ItemsStateImplFromJson(Map<String, dynamic> json) =>
    _$ItemsStateImpl(
      (json['currentIndex'] as num).toInt(),
      (json['items'] as List<dynamic>)
          .map((e) => GameItem.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$$ItemsStateImplToJson(_$ItemsStateImpl instance) =>
    <String, dynamic>{
      'currentIndex': instance.currentIndex,
      'items': instance.items,
    };
