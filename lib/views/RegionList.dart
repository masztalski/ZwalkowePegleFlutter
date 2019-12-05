import 'package:flutter/material.dart';
import 'package:zwalkowe_pegle/components/BasicListItem.dart';
import 'package:zwalkowe_pegle/repositories/PegleRepository.dart';

class RegionList extends StatefulWidget {
  _RegionList createState() => _RegionList();
}

class _RegionList extends State<RegionList> {
  var regions = [
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
    'zachodniopomorskie',
    'dolnośląskie'
  ];

  @override
  void initState() {
    super.initState();
    regions.sort();
  }

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
            return new GestureDetector(
                //You need to make my child interactive
                onTap: () => onRegionSelected(regions[index]),
                child: BasicListItem(regionName: regions[index]));
          },
        ));
  }

  void onRegionSelected(String regionName) {
    PegleRepository().getStationsForRegion(regionName);
  }
}
