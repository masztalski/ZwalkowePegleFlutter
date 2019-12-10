import 'package:flutter/material.dart';

class Toolbar extends StatelessWidget implements PreferredSizeWidget {
  final String mainTitle;
  final String subTitle;

  Toolbar({Key key, this.mainTitle, this.subTitle = ""}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    if (subTitle.isNotEmpty) {
      return AppBar(
          centerTitle: true,
          title: Column(children: [
            Text(mainTitle),
            Text(
              subTitle,
              style: TextStyle(
                inherit: false,
              ),
            )
          ]));
    } else {
      return AppBar(centerTitle: true, title: Text(mainTitle));
    }
  }

  @override
  Size get preferredSize => Size.fromHeight(kToolbarHeight);
}
