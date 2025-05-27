import 'package:flutter/cupertino.dart';
import '../../main.dart';
import '../PageRoute.dart';

class CustomNavigator {
  static final context = navigatorKey.currentContext;
  static const heroTag = "hero";
  static void push(Widget newPage) {
    if (context == null) {
      return;
    }
    Navigator.of(context!).push(
      CustomPageRoute(
        builder: (_) => newPage,
      ),
    );
  }

  static void back() {
    if (context == null) {
      return;
    }
    Navigator.of(context!).pop();
  }

  static void pushReplacement(Widget newPage) {
    if (context == null) {
      return;
    }
    Navigator.of(context!).pushReplacement(
      CustomPageRoute(
        builder: (_) => newPage,
      ),
    );
  }
}