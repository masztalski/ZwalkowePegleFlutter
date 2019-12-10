import 'package:charts_flutter/flutter.dart' as charts;
import 'package:flutter/material.dart';
import 'package:zwalkowe_pegle/bloc/StationDetailsBlock.dart';
import 'package:zwalkowe_pegle/components/EmptyList.dart';
import 'package:zwalkowe_pegle/components/TextWithIcon.dart';
import 'package:zwalkowe_pegle/components/Toolbar.dart';
import 'package:zwalkowe_pegle/components/TrendImage.dart';
import 'package:zwalkowe_pegle/models/River.dart';
import 'package:zwalkowe_pegle/models/StationWithDetails.dart';
import 'package:zwalkowe_pegle/res/Assets.dart';
import 'package:zwalkowe_pegle/res/Strings.dart';
import 'package:zwalkowe_pegle/utils/DateTimeAxisWorkaround.dart';

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
        appBar: Toolbar(
            mainTitle: River.getRiverShortName(selectedStation.riverName),
            subTitle: selectedStation.stationName),
        body: StreamBuilder(
            initialData: _stationDetailsBlock.stationDetails,
            stream: _stationDetailsBlock.getStationDetails,
            builder: (context, AsyncSnapshot<StationWithDetails> snapshot) {
              if (snapshot.data == null || snapshot.data.stationName.isEmpty) {
                return EmptyList();
              } else {
                return Container(
                    padding: const EdgeInsets.all(16),
                    child: Column(
                      children: [
                        _basicData(),
                        SizedBox(height: 20),
                        Container(
                            height: 200, child: _levelChart(snapshot.data)),
                        SizedBox(height: 20),
                        Container(
                            height: 200, child: _dischargeChart(snapshot.data))
                      ],
                    ));
              }
            }));
  }

  Widget _basicData() {
    return Row(children: [
      Expanded(
          flex: 4,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Text(
                Strings.dateOfData(selectedStation.date),
                textAlign: TextAlign.left,
              ),
              SizedBox(height: 15),
              Row(
                children: [
                  Expanded(
                      child: TextWithIcon(
                          imageName: Assets.waterLevel,
                          text:
                              "${selectedStation.currentLevel.toString()} cm")),
                  SizedBox(
                    height: 20,
                  ),
                  Expanded(
                      child: TextWithIcon(
                          imageName: Assets.waterDischarge,
                          text:
                              "${selectedStation.currentDischarge.toString()} m${Strings.superScript3}/s"))
                ],
              )
            ],
          )),
      Expanded(
          flex: 1,
          child: TrendImage(
              trend: selectedStation.trend,
              height: 50,
              width: 30,
              fit: BoxFit.fill)),
    ]);
  }

  Widget _levelChart(StationWithDetails station) {
    if (station.levelsHistory != null && station.levelsHistory.isNotEmpty) {
      var endDate = station.levelsHistory.last.date;
      var startDate = station.levelsHistory
          .elementAt(station.levelsHistory.length - 24)
          .date;
      return charts.TimeSeriesChart(_stationDetailsBlock.getLevelData(station),
          animate: true,
          behaviors: [charts.PanAndZoomBehavior(),charts.SeriesLegend()],
          domainAxis: DateTimeAxisSpecWorkaround(
              viewport: charts.DateTimeExtents(start: startDate, end: endDate),
              tickProviderSpec: charts.AutoDateTimeTickProviderSpec()));
    }
    return Center(child: Text(Strings.dataMissing));
  }

  Widget _dischargeChart(StationWithDetails station) {
    if (station.dischargeHistory != null &&
        station.dischargeHistory.isNotEmpty) {
      var endDate = station.dischargeHistory.last.date;
      var startDate = station.dischargeHistory
          .elementAt(station.dischargeHistory.length - 24)
          .date;
      return charts.TimeSeriesChart(
          _stationDetailsBlock.getDischargeData(station),
          animate: true,
          behaviors: [charts.PanAndZoomBehavior(),charts.SeriesLegend()],
          domainAxis: DateTimeAxisSpecWorkaround(
              viewport: charts.DateTimeExtents(start: startDate, end: endDate),
              tickProviderSpec: charts.AutoDateTimeTickProviderSpec(includeTime: true)),
          primaryMeasureAxis: new charts.NumericAxisSpec(
              renderSpec: new charts.SmallTickRendererSpec(
                // Tick and Label styling here.
              )));
    }
    return Center(child: Text(Strings.dataMissing));
  }
}
