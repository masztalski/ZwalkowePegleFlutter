// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'PegleApi.dart';

// **************************************************************************
// RetrofitGenerator
// **************************************************************************

class _PegleApi implements PegleApi {
  _PegleApi(this._dio) {
    ArgumentError.checkNotNull(_dio, '_dio');
    _dio.options.baseUrl = 'http://api.zwalkowepegle.kylos.pl/';
  }

  final Dio _dio;

  @override
  getStations(wojewodztwo) async {
    ArgumentError.checkNotNull(wojewodztwo, 'wojewodztwo');
    const _extra = <String, dynamic>{};
    final queryParameters = <String, dynamic>{'woj': wojewodztwo};
    const _data = null;
    final _result = await _dio.request('wojewodztwoApi.php',
        queryParameters: queryParameters,
        options: RequestOptions(method: 'GET', headers: {}, extra: _extra),
        data: _data);
    var value = (_result.data as List).map((i) => Station.fromJson(i)).toList();
    return Future.value(value);
  }

  @override
  getStationDetails(stationID) async {
    ArgumentError.checkNotNull(stationID, 'stationID');
    const _extra = <String, dynamic>{};
    final queryParameters = <String, dynamic>{'id': stationID};
    const _data = null;
    final _result = await _dio.request('getStationApi.php',
        queryParameters: queryParameters,
        options: RequestOptions(method: 'GET', headers: {}, extra: _extra),
        data: _data);
    var value = StationWithDetails.fromJson(_result.data);
    return Future.value(value);
  }

  @override
  getLevelRecords(id, kind) async {
    ArgumentError.checkNotNull(id, 'id');
    ArgumentError.checkNotNull(kind, 'kind');
    const _extra = <String, dynamic>{};
    final queryParameters = <String, dynamic>{'id': id, 'kind': kind};
    const _data = null;
    final _result = await _dio.request('/stationHistoryApi.php',
        queryParameters: queryParameters,
        options: RequestOptions(method: 'GET', headers: {}, extra: _extra),
        data: _data);
    var value =
        (_result.data as List).map((i) => LevelRecord.fromJson(i)).toList();
    return Future.value(value);
  }

  @override
  getDischargeRecords(id, kind) async {
    ArgumentError.checkNotNull(id, 'id');
    ArgumentError.checkNotNull(kind, 'kind');
    const _extra = <String, dynamic>{};
    final queryParameters = <String, dynamic>{'id': id, 'kind': kind};
    const _data = null;
    final _result = await _dio.request('/stationHistoryApi.php',
        queryParameters: queryParameters,
        options: RequestOptions(method: 'GET', headers: {}, extra: _extra),
        data: _data);
    var value =
        (_result.data as List).map((i) => DischargeRecord.fromJson(i)).toList();
    return Future.value(value);
  }
}
