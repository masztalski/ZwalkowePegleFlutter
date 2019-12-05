// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'LevelRecord.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

LevelRecord _$LevelRecordFromJson(Map<String, dynamic> json) {
  return LevelRecord(
    json['date'] == null ? null : DateTime.parse(json['date'] as String),
    json['value'] as int,
  );
}

Map<String, dynamic> _$LevelRecordToJson(LevelRecord instance) =>
    <String, dynamic>{
      'date': instance.date?.toIso8601String(),
      'value': instance.value,
    };
