import 'package:flutter/cupertino.dart';

import '../main.dart';

class DefaultPageRoute<T> extends PageRouteBuilder<T> {
  DefaultPageRoute({required WidgetBuilder builder})
      : super(
    transitionDuration: const Duration(milliseconds: 1000),
    pageBuilder: (context, animation, secondaryAnimation) => builder(context),
    transitionsBuilder: (context, animation, secondaryAnimation, child) {
      final slide = Tween<Offset>(begin: const Offset(0.0, 3.0), end: Offset.zero)
          .animate(CurvedAnimation(parent: animation, curve: Curves.fastEaseInToSlowEaseOut));

      return SlideTransition(
          position: slide,
          child: child
      );
    },
  );
}

class PageRouter {
  static final context = navigatorKey.currentContext;
  static const heroTag = "hero";
  static void push(Widget newPage) {
    if (context == null) {
      return;
    }
    Navigator.of(context!).push(
      DefaultPageRoute(
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
      DefaultPageRoute(
        builder: (_) => newPage,
      ),
    );
  }
}