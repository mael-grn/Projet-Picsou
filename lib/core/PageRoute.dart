import 'package:flutter/cupertino.dart';

class CustomPageRoute<T> extends PageRouteBuilder<T> {
  CustomPageRoute({required WidgetBuilder builder})
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

