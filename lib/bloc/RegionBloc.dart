import 'package:zwalkowe_pegle/bloc/Block.dart';
import 'package:rxdart/rxdart.dart';
import 'package:zwalkowe_pegle/models/Region.dart';

class RegionBlock implements Bloc {
  static RegionBlock _regionBlock;

  Region _region;
  PublishSubject<Region> _publishSubjectRegion;

  factory RegionBlock() {
    if (_regionBlock == null) {
      return RegionBlock._();
    }

    return _regionBlock;
  }

  RegionBlock._() {
    _region.regionName = "";
    _publishSubjectRegion = PublishSubject<Region>();
  }

  void regionSelected(String regionName) {
    _region.regionName = regionName;
    _publishSubjectRegion.sink.add(_region);
  }

  Observable<Region> get getRegion => _publishSubjectRegion.stream;

  Region get region => _region;

  @override
  void dispose() {
    _regionBlock = null;
    _publishSubjectRegion.close();
  }
}
