// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'StationWithDetails.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

StationWithDetails _$StationWithDetailsFromJson(Map<String, dynamic> json) {
  return StationWithDetails(
    json['Date'] == null ? null : DateTime.parse(json['Date'] as String),
    json['CurrentLevel'] as int,
    (json['CurrentDischarge'] as num)?.toDouble(),
    json['StationID'] as int,
    json['StationName'] as String,
    json['riverName'] as String,
    (json['riverCourseKm'] as num)?.toDouble(),
    json['trend'] as String,
  );
}

Map<String, dynamic> _$StationWithDetailsToJson(StationWithDetails instance) =>
    <String, dynamic>{
      'Date': instance.date?.toIso8601String(),
      'CurrentLevel': instance.currentLevel,
      'CurrentDischarge': instance.currentDischarge,
      'StationID': instance.stationID,
      'StationName': instance.stationName,
      'riverName': instance.riverName,
      'riverCourseKm': instance.riverCourseKm,
      'trend': instance.trend,
    };
