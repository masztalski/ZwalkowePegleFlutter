import 'package:retrofit/retrofit.dart';
import 'package:dio/dio.dart';
import 'package:zwalkowe_pegle/models/DischargeRecord.dart';
import 'package:zwalkowe_pegle/models/LevelRecord.dart';
import 'package:zwalkowe_pegle/models/Station.dart';
import 'package:zwalkowe_pegle/models/StationWithDetails.dart';

part 'PegleApi.g.dart';

@RestApi(baseUrl: "http://api.zwalkowepegle.kylos.pl/")
abstract class PegleApi {
  factory PegleApi(Dio dio) = _PegleApi;

  @GET("wojewodztwoApi.php")
  Future<List<Station>> getStations(@Query("woj") String wojewodztwo);

  @GET("getStationApi.php")
  Future<StationWithDetails> getStationDetails(@Query("id") String stationID);

  @GET("/stationHistoryApi.php")
  Future<List<LevelRecord>> getLevelRecords(@Query("id") int id, @Query("kind") String kind);

  @GET("/stationHistoryApi.php")
  Future<List<DischargeRecord>> getDischargeRecords(@Query("id") int id, @Query("kind") String kind);
}
