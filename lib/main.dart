import 'package:flutter/material.dart';
import 'package:zwalkowe_pegle/views/RegionList.dart';

void main() => runApp(Pegle());

class Pegle extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.green,
        accentColor: Colors.purpleAccent
      ),
      home: RegionList(),
    );
  }
}
