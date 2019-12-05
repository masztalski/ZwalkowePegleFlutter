
import 'package:json_annotation/json_annotation.dart';

part 'DischargeRecord.g.dart';

@JsonSerializable()
class DischargeRecord {
  final DateTime date;
  final double value;

  DischargeRecord(this.date, this.value);

  factory DischargeRecord.fromJson(Map<String, dynamic> json) => _$DischargeRecordFromJson(json);

}