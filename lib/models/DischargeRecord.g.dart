// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'DischargeRecord.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

DischargeRecord _$DischargeRecordFromJson(Map<String, dynamic> json) {
  return DischargeRecord(
    json['date'] == null ? null : DateTime.parse(json['date'] as String),
    (json['value'] as num)?.toDouble(),
  );
}

Map<String, dynamic> _$DischargeRecordToJson(DischargeRecord instance) =>
    <String, dynamic>{
      'date': instance.date?.toIso8601String(),
      'value': instance.value,
    };
