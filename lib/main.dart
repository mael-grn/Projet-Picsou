import 'package:flutter/material.dart';
import 'routes/app_router.dart';       // ton fichier avec generateRoute
import 'routes/app_routes.dart';      // pour utiliser AppRoutes.demo
import 'core/theme/app_theme.dart';
void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'PICSOU',
      debugShowCheckedModeBanner: false,
      initialRoute: AppRoutes.demo,
      onGenerateRoute: generateRoute,
      theme: appTheme,
    );
  }
}
