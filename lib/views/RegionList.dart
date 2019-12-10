import 'package:flutter/material.dart';
import 'package:zwalkowe_pegle/components/BasicListItem.dart';
import 'package:zwalkowe_pegle/components/Toolbar.dart';
import 'package:zwalkowe_pegle/models/Region.dart';
import 'package:zwalkowe_pegle/res/Strings.dart';
import 'package:zwalkowe_pegle/views/RiversList.dart';

class RegionList extends StatefulWidget {
  _RegionList createState() => _RegionList();
}

class _RegionList extends State<RegionList> {
  var regions;

  _RegionList() {
    regions = Strings.regions.map((it) => Region(regionName: it));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar:
            Toolbar(mainTitle: Strings.appName, subTitle: Strings.chooseRegion),
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
