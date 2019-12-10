import 'package:rxdart/rxdart.dart';
import 'package:zwalkowe_pegle/models/DischargeRecord.dart';
import 'package:zwalkowe_pegle/models/LevelRecord.dart';
import 'package:zwalkowe_pegle/models/Record.dart';
import 'package:zwalkowe_pegle/models/StationWithDetails.dart';
import 'package:zwalkowe_pegle/repositories/PegleRepository.dart';
import 'package:charts_flutter/flutter.dart' as charts;
import 'package:zwalkowe_pegle/res/Strings.dart';

import 'Block.dart';

class StationDetailsBlock extends Bloc {
  static StationDetailsBlock _stationDetailsBlock;
  PublishSubject<StationWithDetails> _publishSubjectStationWithDetails;
  StationWithDetails _stationWithDetails;
  PegleRepository _repository;

  factory StationDetailsBlock() {
    if (_stationDetailsBlock == null) {
      _stationDetailsBlock = StationDetailsBlock._();
    }
    return _stationDetailsBlock;
  }

  StationDetailsBlock._() {
    _repository = PegleRepository();
    _publishSubjectStationWithDetails = PublishSubject<StationWithDetails>();
  }

  void getStationHistory(StationWithDetails station) async {
    var futures = <Future<List<Record>>>[];
    futures.add(_repository.getLevelHistoryForStation(station.stationID));
    futures.add(_repository.getDischargeHistoryForStation(station.stationID));
    await Future.wait(futures).then((it) {
      _stationWithDetails = station;
      _stationWithDetails.levelsHistory = it.whereType<List<LevelRecord>>().first.toList(growable: false);
      _stationWithDetails.dischargeHistory = it.whereType<List<DischargeRecord>>().first.toList(growable: false);
      _publishSubjectStationWithDetails.sink.add(_stationWithDetails);
    });
  }

  List<charts.Series<LevelRecord, DateTime>> getLevelData(
      StationWithDetails station) {
    return [
      charts.Series<LevelRecord, DateTime>(
        id: Strings.levelChartId,
        colorFn: (_, __) => charts.MaterialPalette.green.shadeDefault,
        domainFn: (LevelRecord record, _) => record.date,
        measureFn: (LevelRecord record, _) => record.value,
        data: station.levelsHistory,
      )
    ];
  }

  List<charts.Series<DischargeRecord, DateTime>> getDischargeData(
      StationWithDetails station) {
    return [
      charts.Series<DischargeRecord, DateTime>(
        id: Strings.dischargeChartId,
        colorFn: (_, __) => charts.MaterialPalette.red.shadeDefault,
        domainFn: (DischargeRecord record, _) => record.date,
        measureFn: (DischargeRecord record, _) => record.value,
        data: station.dischargeHistory,
      )
    ];
  }

  @override
  void dispose() {
    _publishSubjectStationWithDetails.close();
  }

  Observable<StationWithDetails> get getStationDetails => _publishSubjectStationWithDetails.stream;

  StationWithDetails get stationDetails => _stationWithDetails;
}
