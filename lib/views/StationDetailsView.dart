import 'package:flutter/material.dart';
import 'package:zwalkowe_pegle/bloc/StationDetailsBlock.dart';
import 'package:zwalkowe_pegle/components/EmptyList.dart';
import 'package:zwalkowe_pegle/models/DischargeRecord.dart';
import 'package:zwalkowe_pegle/models/LevelRecord.dart';
import 'package:zwalkowe_pegle/models/River.dart';
import 'package:zwalkowe_pegle/models/StationWithDetails.dart';
import 'package:charts_flutter/flutter.dart' as charts;
import 'package:intl/intl.dart';

class StationDetailsView extends StatefulWidget {
  final StationWithDetails selectedStation;

  _StationDetailsView createState() =>
      _StationDetailsView(selectedStation: this.selectedStation);

  StationDetailsView({Key key, @required this.selectedStation})
      : super(key: key);
}

class _StationDetailsView extends State<StationDetailsView> {
  final StationWithDetails selectedStation;
  final StationDetailsBlock _stationDetailsBlock = StationDetailsBlock();

  _StationDetailsView({Key key, @required this.selectedStation}) : super();

  @override
  void initState() {
    super.initState();
    _stationDetailsBlock.getStationHistory(selectedStation);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
            centerTitle: true,
            title: Column(children: [
              Text(River.getRiverShortName(selectedStation.riverName)),
              Text(
                selectedStation.stationName,
                style: TextStyle(
                  inherit: false,
                ),
              )
            ])),
        body: StreamBuilder(
            initialData: _stationDetailsBlock.stationDetails,
            stream: _stationDetailsBlock.getStationDetails,
            builder: (context, AsyncSnapshot<StationWithDetails> snapshot) {
              if (snapshot.data == null || snapshot.data.stationName.isEmpty) {
                return EmptyList();
              } else {
                return Column(
                  children: [
                    _basicData(),
                    SizedBox(height: 20),
                    Container(height: 200, child: _levelChart(snapshot.data)),
                    SizedBox(height: 20),
                    Container(
                        height: 200, child: _dischargeChart(snapshot.data))
                  ],
                );
              }
            }));
  }

  Widget _basicData() {
    var formatter = DateFormat('yyyy-MM-dd HH:mm');
    return Row(children: [
      Expanded(child: Column(
        children: [
          Text("Dane z ${formatter.format(selectedStation.date)}", textAlign: TextAlign.left,),
          Row(
            children: [
              Expanded(child: _textWithIcon(
                  "assets/ruler.png", selectedStation.currentLevel.toString())),
              Expanded(child: _textWithIcon("assets/speedometer.png",
                  selectedStation.currentDischarge.toString()))
            ],
          )
        ],
      )),
      _trendImage(selectedStation.trend),
    ]);
  }

  Widget _textWithIcon(String imageName, String value) {
    return Row(children: [
      _smallImage(imageName),
      SizedBox(width: 10,),
      Text(value),
    ]);
  }

  Widget _smallImage(String imageName) {
    return Image(
      image: AssetImage(imageName),
      height: 20,
    );
  }

  Widget _trendImage(String trend) {
    String _imageName;
    switch (trend) {
      case "const":
        _imageName = 'assets/trending-neutral.png';
        break;
      case "down":
        _imageName = 'assets/trending-down.png';
        break;
      case "up":
        _imageName = 'assets/trending-up.png';
        break;
      default:
        _imageName = 'assets/help.png';
    }
    return Image(
      image: AssetImage(_imageName),
      height: 40,
    );
  }

  Widget _levelChart(StationWithDetails station) {
    if (station.levelsHistory != null && station.levelsHistory.isNotEmpty) {
      return charts.TimeSeriesChart(getLevelData(station), animate: true);
    }
    return Center(child: Text("Brak danych"));
  }

  Widget _dischargeChart(StationWithDetails station) {
    if (station.dischargeHistory != null &&
        station.dischargeHistory.isNotEmpty) {
      return charts.TimeSeriesChart(getDischargeData(station), animate: true);
    }
    return Center(child: Text("Brak danych"));
  }

  List<charts.Series<LevelRecord, DateTime>> getLevelData(
      StationWithDetails station) {
    return [
      charts.Series<LevelRecord, DateTime>(
        id: 'Poziom wody [cm]',
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
        id: 'Przepływ [m${String.fromCharCode(0x00B3)}/s]',
        colorFn: (_, __) => charts.MaterialPalette.green.shadeDefault,
        domainFn: (DischargeRecord record, _) => record.date,
        measureFn: (DischargeRecord record, _) => record.value,
        data: station.dischargeHistory,
      )
    ];
  }
}
