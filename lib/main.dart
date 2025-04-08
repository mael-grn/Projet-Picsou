import 'package:flutter/material.dart';
import 'package:projet_picsou/services/auth_service.dart';
import 'package:projet_picsou/widgets/my_app.dart';
import 'package:provider/provider.dart';
import 'controllers/auth_controller.dart';

void main() async {
  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => AuthController(authService: AuthService())),
      ],
      child: const MyApp(),
    ),
  );
}


