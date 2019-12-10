
import 'package:flutter/cupertino.dart';

class TextWithIcon extends StatelessWidget {
  final String imageName;
  final String text;

  TextWithIcon({Key key, this.imageName, this.text}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(children: [
      Image(
        image: AssetImage(imageName),
        height: 20,
      ),
      SizedBox(
        width: 10,
      ),
      Text(text),
    ]);
  }

}