import 'package:flutter/material.dart';
import 'package:projet_picsou/views/friends_view.dart';
import 'package:projet_picsou/views/home_view.dart';
import 'package:projet_picsou/views/me_view.dart';
import 'package:projet_picsou/views/money_view.dart';
import 'app_routes.dart';

Route<dynamic> generateRoute(RouteSettings settings) {
  switch (settings.name) {
    case AppRoutes.home:
      return MaterialPageRoute(builder: (_) => HomeView());
    case AppRoutes.friends:
      return MaterialPageRoute(builder: (_) => FriendsView());
    case AppRoutes.money:
      return MaterialPageRoute(builder: (_) => MoneyView());
    case AppRoutes.me:
      return MaterialPageRoute(builder: (_) => MeView());
    default:
      return MaterialPageRoute(builder: (_) => Scaffold(
        body: Center(child: Text('Page not found')),
      ));
  }
}