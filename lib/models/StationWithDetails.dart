import 'package:json_annotation/json_annotation.dart';
import 'package:zwalkowe_pegle/models/DischargeRecord.dart';
import 'package:zwalkowe_pegle/models/LevelRecord.dart';

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

  List<LevelRecord> levelsHistory;
  List<DischargeRecord> dischargeHistory;

  StationWithDetails(this.date, this.currentLevel, this.currentDischarge,
      this.stationID, this.stationName, this.riverName, this.riverCourseKm,
      this.trend);

  factory StationWithDetails.fromJson(Map<String, dynamic> json) => _$StationWithDetailsFromJson(json);


}