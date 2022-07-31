// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'game_state.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$_GameState _$$_GameStateFromJson(Map<String, dynamic> json) => _$_GameState(
      (json['countries'] as List<dynamic>)
          .map((e) => Country.fromJson(e as Map<String, dynamic>))
          .toList(),
      json['score'] as int,
      json['topScore'] as int,
    );

Map<String, dynamic> _$$_GameStateToJson(_$_GameState instance) =>
    <String, dynamic>{
      'countries': instance.countries,
      'score': instance.score,
      'topScore': instance.topScore,
    };
