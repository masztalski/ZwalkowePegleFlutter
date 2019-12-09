import 'package:zwalkowe_pegle/bloc/Block.dart';
import 'package:zwalkowe_pegle/models/River.dart';
import 'package:zwalkowe_pegle/models/Station.dart';
import 'package:zwalkowe_pegle/models/StationWithDetails.dart';
import 'package:zwalkowe_pegle/repositories/PegleRepository.dart';
import 'package:rxdart/rxdart.dart';

import 'RiverListBloc.dart';

class RiverStationsBlock extends Bloc {
  static RiverListBlock _riverListBlock;
  static RiverStationsBlock _riverStationsBlock;
  PublishSubject<List<StationWithDetails>> _publishSubjectRiverStations;
  List<StationWithDetails> _riverStations;
  PegleRepository _repository;

  factory RiverStationsBlock() {
    if (_riverStationsBlock == null) {
      _riverStationsBlock = RiverStationsBlock._();
    }

    return _riverStationsBlock;
  }

  RiverStationsBlock._() {
    _repository = PegleRepository();
    _riverListBlock = RiverListBlock();
    _publishSubjectRiverStations = PublishSubject<List<StationWithDetails>>();
  }

  @override
  void dispose() {
   _publishSubjectRiverStations.close();
  }

  void getStationsForRiver(River river) async {
    var riverStations = _riverListBlock.regionStations
        .where((it) => it.river == river.fullName)
        .toList(growable: false);
    var futures = <Future<StationWithDetails>>[];
    riverStations.forEach((station) {
      futures.add(_repository.getStationDetailsById(station.stationID));
    });
    await Future.wait(futures).then((it) {
      _riverStations = it;
      _publishSubjectRiverStations.sink.add(it);
    });
  }

  Observable<List<StationWithDetails>> get getRiverStations => _publishSubjectRiverStations.stream;

  List<StationWithDetails> get riverStations => _riverStations;
}
