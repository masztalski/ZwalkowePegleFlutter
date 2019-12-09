import 'package:rxdart/rxdart.dart';
import 'package:zwalkowe_pegle/models/DischargeRecord.dart';
import 'package:zwalkowe_pegle/models/LevelRecord.dart';
import 'package:zwalkowe_pegle/models/Record.dart';
import 'package:zwalkowe_pegle/models/StationWithDetails.dart';
import 'package:zwalkowe_pegle/repositories/PegleRepository.dart';

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

  @override
  void dispose() {
    _publishSubjectStationWithDetails.close();
  }

  Observable<StationWithDetails> get getStationDetails => _publishSubjectStationWithDetails.stream;

  StationWithDetails get stationDetails => _stationWithDetails;
}
