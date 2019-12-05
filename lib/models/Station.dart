import 'package:json_annotation/json_annotation.dart';

part 'Station.g.dart';

@JsonSerializable()
class Station {
  @JsonKey(name: "station_id")
  final String stationID;
  final String river;

  Station({this.stationID, this.river});
  factory Station.fromJson(Map<String, dynamic> json) => _$StationFromJson(json);

}