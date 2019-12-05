// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'Station.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Station _$StationFromJson(Map<String, dynamic> json) {
  return Station(
    stationID: json['station_id'] as String,
    river: json['river'] as String,
  );
}

Map<String, dynamic> _$StationToJson(Station instance) => <String, dynamic>{
      'station_id': instance.stationID,
      'river': instance.river,
    };
