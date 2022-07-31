// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'game_item.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$_GameItem _$$_GameItemFromJson(Map<String, dynamic> json) => _$_GameItem(
      Country.fromJson(json['original'] as Map<String, dynamic>),
      fake: json['fake'] == null
          ? null
          : Country.fromJson(json['fake'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$$_GameItemToJson(_$_GameItem instance) =>
    <String, dynamic>{
      'original': instance.original,
      'fake': instance.fake,
    };
