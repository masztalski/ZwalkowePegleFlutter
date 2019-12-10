import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:zwalkowe_pegle/bloc/RiverStationsBloc.dart';
import 'package:zwalkowe_pegle/components/EmptyList.dart';
import 'package:zwalkowe_pegle/components/StationListItem.dart';
import 'package:zwalkowe_pegle/components/Toolbar.dart';
import 'package:zwalkowe_pegle/models/River.dart';
import 'package:zwalkowe_pegle/models/StationWithDetails.dart';
import 'package:zwalkowe_pegle/views/StationDetailsView.dart';

class RiverStations extends StatefulWidget {
  final River selectedRiver;

  _RiverStations createState() =>
      _RiverStations(selectedRiver: this.selectedRiver);

  RiverStations({Key key, @required this.selectedRiver}) : super(key: key);
}

class _RiverStations extends State<RiverStations> {
  final River selectedRiver;
  RiverStationsBlock _riverStationsBlock = RiverStationsBlock();

  _RiverStations({Key key, @required this.selectedRiver}) : super();

  @override
  void initState() {
    super.initState();
    _riverStationsBlock.getStationsForRiver(selectedRiver);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: Toolbar(mainTitle: selectedRiver.shortName),
        body: StreamBuilder(
            initialData: _riverStationsBlock.riverStations,
            stream: _riverStationsBlock.getRiverStations,
            builder:
                (context, AsyncSnapshot<List<StationWithDetails>> snapshot) {
              if (snapshot.data == null || snapshot.data.isEmpty) {
                return EmptyList();
              } else {
                return ListView.builder(
                    itemCount: snapshot.data.length,
                    itemBuilder: (BuildContext ctxt, int index) {
                      return GestureDetector(
                          onTap: () => _onStationSelected(snapshot.data[index]),
                          child:
                              StationListItem(station: snapshot.data[index]));
                    });
              }
            }));
  }

  void _onStationSelected(StationWithDetails station) {
    Navigator.push(context,
        MaterialPageRoute<void>(builder: (BuildContext context) {
      return StationDetailsView(
        selectedStation: station,
      );
    }));
  }
}
