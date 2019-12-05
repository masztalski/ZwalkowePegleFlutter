
import 'package:flutter/cupertino.dart';

class BasicListItem extends StatelessWidget {
  final String regionName;
  BasicListItem({Key key, this.regionName}) : super(key: key);

  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(16),
      child: Text(
        regionName,
        style: TextStyle(
          fontSize: 15
      ),
      ),
    );
  }
}