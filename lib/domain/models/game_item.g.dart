// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'game_item.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$GameItemImpl _$$GameItemImplFromJson(Map<String, dynamic> json) =>
    _$GameItemImpl(
      Country.fromJson(json['original'] as Map<String, dynamic>),
      fake: json['fake'] == null
          ? null
          : Country.fromJson(json['fake'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$$GameItemImplToJson(_$GameItemImpl instance) =>
    <String, dynamic>{
      'original': instance.original,
      'fake': instance.fake,
    };
