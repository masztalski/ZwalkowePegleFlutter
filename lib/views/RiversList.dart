import 'package:flutter/material.dart';
import 'package:zwalkowe_pegle/bloc/RiverListBloc.dart';
import 'package:zwalkowe_pegle/components/BasicListItem.dart';
import 'package:zwalkowe_pegle/components/EmptyList.dart';
import 'package:zwalkowe_pegle/models/Region.dart';
import 'package:zwalkowe_pegle/models/River.dart';
import 'package:zwalkowe_pegle/views/RiverStations.dart';

class RiverList extends StatefulWidget {
  final Region selectedRegion;

  _RiverList createState() => _RiverList(selectedRegion: this.selectedRegion);

  RiverList({Key key, @required this.selectedRegion}) : super(key: key);
}

class _RiverList extends State<RiverList> {
  final Region selectedRegion;
  RiverListBlock _riverListBlock = RiverListBlock();

  _RiverList({Key key, @required this.selectedRegion}) : super();

  @override
  void initState() {
    super.initState();
    _riverListBlock.getRivers(selectedRegion);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
            centerTitle: true,
            title: Column(children: [
              Text("Zwałkowe Pegle"),
              Text(
                selectedRegion.regionName,
                style: TextStyle(
                  inherit: false,
                ),
              )
            ])),
        body: StreamBuilder(
            initialData: _riverListBlock.regionRivers,
            stream: _riverListBlock.getRiversStream,
            builder: (context, AsyncSnapshot<List<River>> snapshot) {
              if (snapshot.data == null || snapshot.data.isEmpty) {
                return EmptyList();
              } else {
                return ListView.builder(
                    itemCount: snapshot.data.length,
                    itemBuilder: (BuildContext ctxt, int index) {
                      return GestureDetector(
                          onTap: () => _onRiverSelected(snapshot.data[index]),
                          child: BasicListItem(
                              regionName: snapshot.data[index].shortName));
                    });
              }
            }));
  }

  void _onRiverSelected(River river) {
    Navigator.push(context,
        MaterialPageRoute<void>(builder: (BuildContext context) {
      return RiverStations(selectedRiver: river);
    }));
  }
}
