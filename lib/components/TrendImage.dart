import 'package:flutter/cupertino.dart';
import 'package:zwalkowe_pegle/res/Assets.dart';

class TrendImage extends StatelessWidget {
  final String trend;
  final BoxFit fit;
  final double height;
  final double width;

  TrendImage({Key key, this.trend, this.fit = BoxFit.scaleDown, this.height = 40, this.width = 40})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    String _imageName;
    switch (trend) {
      case "const":
        _imageName = Assets.trendConst;
        break;
      case "down":
        _imageName = Assets.trendDown;
        break;
      case "up":
        _imageName = Assets.trendUp;
        break;
      default:
        _imageName = Assets.trendUnknown;
    }

    return Image(
      image: AssetImage(_imageName),
      fit: this.fit,
      height: this.height,
      width: this.width,
    );
  }
}
