
import 'package:json_annotation/json_annotation.dart';

part 'LevelRecord.g.dart';

@JsonSerializable()
class LevelRecord {
  final DateTime date;
  final int value;

  LevelRecord(this.date, this.value);

  factory LevelRecord.fromJson(Map<String, dynamic> json) => _$LevelRecordFromJson(json);

}