import 'package:flutter/cupertino.dart';

class DefaultPageRoute<T> extends PageRouteBuilder<T> {
  DefaultPageRoute({required WidgetBuilder builder})
      : super(
    pageBuilder: (context, animation, secondaryAnimation) => builder(context),
    transitionsBuilder: (context, animation, secondaryAnimation, child) {
      // Slide + scale sur la nouvelle page
      final slide = Tween<Offset>(begin: const Offset(1.0, 0.0), end: Offset.zero)
          .animate(CurvedAnimation(parent: animation, curve: Curves.ease));
      final scale = Tween<double>(begin: 0.5, end: 1.0)
          .animate(CurvedAnimation(parent: animation, curve: Curves.ease));

      return SlideTransition(
        position: slide,
        child: ScaleTransition(
          scale: scale,
          child: child,
        ),
      );
    },
  );
}