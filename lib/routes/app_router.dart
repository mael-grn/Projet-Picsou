import 'package:flutter/material.dart';
import 'package:projet_picsou/views/friends_page.dart';
import 'package:projet_picsou/views/home_page.dart';
import 'package:projet_picsou/views/me_page.dart';
import 'package:projet_picsou/views/money_page.dart';
import 'app_routes.dart';

Route<dynamic> generateRoute(RouteSettings settings) {
  switch (settings.name) {
    case AppRoutes.home:
      return MaterialPageRoute(builder: (_) => HomePage());
    case AppRoutes.friends:
      return MaterialPageRoute(builder: (_) => FriendsPage());
    case AppRoutes.money:
      return MaterialPageRoute(builder: (_) => MoneyPage());
    case AppRoutes.me:
      return MaterialPageRoute(builder: (_) => MePage());
    default:
      return MaterialPageRoute(builder: (_) => Scaffold(
        body: Center(child: Text('Page not found')),
      ));
  }
}