import 'package:flutter/material.dart';
import 'package:projet_picsou/views/error_screen_view.dart';
import 'package:projet_picsou/views/home_view.dart';
import 'package:projet_picsou/views/splash_screen_view.dart';
import 'package:projet_picsou/widgets/global_layout.dart';
import 'package:provider/provider.dart';
import '../controllers/auth_controller.dart';
import '../core/theme/app_theme.dart';
import '../views/loading_sceen_view.dart';

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  void initState() {
    super.initState();
    // on charge le user à l'initialisation
    Future.microtask(() =>
        Provider.of<AuthController>(context, listen: false).loadUser());
  }

  @override
  Widget build(BuildContext context) {
    final authController = context.watch<AuthController>();

    Widget content;

    if (authController.isLoading) {
      content = const LoadingSceenView();
    } else if (authController.error != null) {
      content = ErrorScreenView(authController.error!);
    } else if (authController.user != null) {
      content = const GlobalLayout();
    } else {
      content = const SplashScreenView();
    }

    return MaterialApp(
      title: 'PICSOU',
      debugShowCheckedModeBanner: false,
      home: content,
      theme: appTheme,
    );
  }
}
