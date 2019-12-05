import 'package:dio/dio.dart';
import 'package:zwalkowe_pegle/data/PegleApi.dart';
import 'package:zwalkowe_pegle/models/DischargeRecord.dart';
import 'package:zwalkowe_pegle/models/LevelRecord.dart';
import 'package:zwalkowe_pegle/models/Station.dart';
import 'package:zwalkowe_pegle/models/StationWithDetails.dart';

class PegleRepository {
  static PegleRepository _pegleRepository;

  PegleApi _client;

  factory PegleRepository() {
    if (_pegleRepository == null) {
      _pegleRepository = PegleRepository._();
    }
    return _pegleRepository;
  }

  PegleRepository._(){
    this._client = PegleApi(Dio());
  }

  Future<List<Station>> getStationsForRegion(String region) {
    return _client.getStations(region).catchError((Object obj) {
      // non-200 error goes here.
      switch (obj.runtimeType) {
        case DioError:
          // Here's the sample to get the failed response error code and message
          final res = (obj as DioError).response;
          print("Got error : ${res.statusCode} -> ${res.statusMessage}");
          break;
        default:
          print("Got error");
      }
    });
  }

  Future<StationWithDetails> getStationDetailsById(String stationID) {
    return _client.getStationDetails(stationID).catchError((Object obj) {
      // non-200 error goes here.
      switch (obj.runtimeType) {
        case DioError:
        // Here's the sample to get the failed response error code and message
          final res = (obj as DioError).response;
          print("Got error : ${res.statusCode} -> ${res.statusMessage}");
          break;
        default:
          print("Got error");
      }
    });
  }

  Future<List<DischargeRecord>> getDischargeHistoryForStation(int stationID) {
    return _client.getDischargeRecords(stationID, "przeplyw").catchError((Object obj) {
      // non-200 error goes here.
      switch (obj.runtimeType) {
        case DioError:
        // Here's the sample to get the failed response error code and message
          final res = (obj as DioError).response;
          print("Got error : ${res.statusCode} -> ${res.statusMessage}");
          break;
        default:
          print("Got error");
      }
    });
  }

  Future<List<LevelRecord>> getLevelHistoryForStation(int stationID) {
    return _client.getLevelRecords(stationID, "level").catchError((Object obj) {
      // non-200 error goes here.
      switch (obj.runtimeType) {
        case DioError:
        // Here's the sample to get the failed response error code and message
          final res = (obj as DioError).response;
          print("Got error : ${res.statusCode} -> ${res.statusMessage}");
          break;
        default:
          print("Got error");
      }
    });
  }

  //TODO add BLOCs transforming list of station into list of rivers per station
}
