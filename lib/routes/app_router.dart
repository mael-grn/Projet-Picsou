// routes/app_router.dart
import 'package:flutter/material.dart';
import '../features/demo/demo_screen.dart';
import 'app_routes.dart';

Route<dynamic> generateRoute(RouteSettings settings) {
  switch (settings.name) {
    case AppRoutes.demo:
      return MaterialPageRoute(builder: (_) => Demo());
    default:
      return MaterialPageRoute(builder: (_) => Scaffold(
        body: Center(child: Text('Page not found')),
      ));
  }
}