import 'package:json_annotation/json_annotation.dart';

import 'Record.dart';

part 'DischargeRecord.g.dart';

@JsonSerializable()
class DischargeRecord implements Record {
  final DateTime date;
  final double value;

  DischargeRecord(this.date, this.value);

  factory DischargeRecord.fromJson(Map<String, dynamic> json) =>
      _$DischargeRecordFromJson(json);
}
