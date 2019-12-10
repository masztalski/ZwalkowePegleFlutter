import 'package:rxdart/rxdart.dart';
import 'package:zwalkowe_pegle/models/Region.dart';
import 'package:zwalkowe_pegle/models/River.dart';
import 'package:zwalkowe_pegle/models/Station.dart';
import 'package:zwalkowe_pegle/repositories/PegleRepository.dart';

import 'Block.dart';

class RiverListBlock extends Bloc {
  static RiverListBlock _riverListBlock;
  PublishSubject<List<River>> _publishSubjectRiver;
  List<River> _regionRivers;
  List<Station> _regionStations;
  PegleRepository _repository;

  factory RiverListBlock() {
    if (_riverListBlock == null) {
      _riverListBlock = RiverListBlock._();
    }

    return _riverListBlock;
  }

  RiverListBlock._() {
    _repository = PegleRepository();
    _publishSubjectRiver = PublishSubject<List<River>>();
  }

  @override
  void dispose() {
    _publishSubjectRiver.close();
  }

  void getRivers(Region region) {
    _repository.getStationsForRegion(region.regionName).then((it) {
      _regionStations = it.toList(growable: false);
      return it.map((it) => it.river).toSet().map(
          (it) => River(shortName: River.getRiverShortName(it), fullName: it));
    }).then((it) {
      List<River> _downloadedRivers = it.toList(growable: false);
      _downloadedRivers.sort((a, b) => a.fullName.compareTo(b.fullName));
      _publishSubjectRiver.sink.add(_downloadedRivers);
      _regionRivers = _downloadedRivers;
    });
  }

  Observable<List<River>> get getRiversStream => _publishSubjectRiver.stream;

  List<River> get regionRivers => _regionRivers;

  List<Station> get regionStations => _regionStations;
}
