import 'package:flutter/foundation.dart';
import 'package:flutter/widgets.dart';

class PlatformWidget extends StatelessWidget {
  final WidgetBuilder androidBuilder;
  final WidgetBuilder iosBuilder;
  // final WidgetBuilder windowsBuilder;

  const PlatformWidget({
    Key? key,
    required this.androidBuilder,
    required this.iosBuilder,
    //required this.windowsBuilder
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    switch (defaultTargetPlatform) {
      case TargetPlatform.android:
        return androidBuilder(context);
      case TargetPlatform.iOS:
        return iosBuilder(context);
      //case TargetPlatform.windows:
      //return windowsBuilder(context);
      default:
        return androidBuilder(context);
    }
  }
}
