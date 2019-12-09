import 'package:flutter/material.dart';
import 'package:zwalkowe_pegle/components/BasicListItem.dart';
import 'package:zwalkowe_pegle/models/Region.dart';
import 'package:zwalkowe_pegle/views/RiversList.dart';

class RegionList extends StatefulWidget {
  _RegionList createState() => _RegionList();
}

class _RegionList extends State<RegionList> {
  var regions = [
    'dolnośląskie',
    'kujawsko-Pomorskie',
    'lubelskie',
    'lubuskie',
    'łódzkie',
    'małopolskie',
    'mazowieckie',
    'opolskie',
    'podkarpackie',
    'podlaskie',
    'pomorskie',
    'śląskie',
    'świętokrzyskie',
    'warmińsko-mazurskie',
    'wielkopolskie',
    'zachodniopomorskie'
  ].map((it) => Region(regionName: it));

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
            centerTitle: true,
            title: Column(children: [
              Text("Zwałkowe Pegle"),
              Text(
                "wybierz województwo",
                style: TextStyle(
                  inherit: false,
                ),
              )
            ])),
        body: ListView.builder(
          itemCount: regions.length,
          itemBuilder: (BuildContext ctxt, int index) {
            return GestureDetector(
                onTap: () => onRegionSelected(regions.elementAt(index)),
                child: BasicListItem(
                    regionName: regions.elementAt(index).regionName));
          },
        ));
  }

  void onRegionSelected(Region region) {
    Navigator.push(context,
        MaterialPageRoute<void>(builder: (BuildContext context) {
      return RiverList(selectedRegion: region);
    }));
  }
}
