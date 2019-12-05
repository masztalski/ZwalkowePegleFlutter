import 'package:json_annotation/json_annotation.dart';

part 'StationWithDetails.g.dart';

@JsonSerializable()
class StationWithDetails {
  @JsonKey(name: "Date")
  final DateTime date;
  @JsonKey(name: "CurrentLevel")
  final int currentLevel;
  @JsonKey(name: "CurrentDischarge")
  final double currentDischarge;
  @JsonKey(name: "StationID")
  final int stationID;
  @JsonKey(name: "StationName")
  final String stationName;
  final String riverName;
  final double riverCourseKm;
  final String trend;

  StationWithDetails(this.date, this.currentLevel, this.currentDischarge,
      this.stationID, this.stationName, this.riverName, this.riverCourseKm,
      this.trend);

  factory StationWithDetails.fromJson(Map<String, dynamic> json) => _$StationWithDetailsFromJson(json);


}