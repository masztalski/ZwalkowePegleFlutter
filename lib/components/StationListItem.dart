import 'package:flutter/material.dart';
import 'package:zwalkowe_pegle/models/StationWithDetails.dart';

import 'TrendImage.dart';

class StationListItem extends StatelessWidget {
  final StationWithDetails station;

  StationListItem({Key key, this.station}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
        padding: const EdgeInsets.all(16),
        child: Row(children: [
          Expanded(child: Text(station.stationName)),
          Expanded(
              child: Column(
            children: [
              Text(station.currentLevel.toString() + " cm"),
              SizedBox(height: 10),
              Text(
                  "${station.currentDischarge.toString()} m${String.fromCharCode(0x00B3)}/s")
            ],
          )),
          Expanded(child: TrendImage(trend: station.trend))
        ]));
  }
}
