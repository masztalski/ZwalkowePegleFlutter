
import 'package:json_annotation/json_annotation.dart';

import 'Record.dart';

part 'LevelRecord.g.dart';

@JsonSerializable()
class LevelRecord implements Record{
  final DateTime date;
  final int value;

  LevelRecord(this.date, this.value);

  factory LevelRecord.fromJson(Map<String, dynamic> json) => _$LevelRecordFromJson(json);

}