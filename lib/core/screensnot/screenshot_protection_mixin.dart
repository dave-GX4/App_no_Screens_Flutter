import 'package:flutter/widgets.dart';
import 'package:no_screenshot/no_screenshot.dart';


mixin ScreenshotProtectionMixin<T extends StatefulWidget> on State<T> {
  final _noScreenshot = NoScreenshot.instance;

  @override
  void initState() {
    super.initState();
    _noScreenshot.screenshotOff();
    print("SCREENSHOTS DESACTIVADOS en ${T.toString()}");
  }

  @override
  void dispose() {
    _noScreenshot.screenshotOn();
    print("SCREENSHOTS ACTIVADOS al salir de ${T.toString()}");
    super.dispose();
  }
}