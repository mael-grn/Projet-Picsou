import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:projet_picsou/controllers/entry_point_controller.dart';
import 'package:projet_picsou/controllers/me_controller.dart';
import 'package:projet_picsou/services/auth_service.dart';
import 'package:projet_picsou/views/entry_point_view.dart';
import 'package:provider/provider.dart';
import 'controllers/auth_controller.dart';


void main() async {

  WidgetsFlutterBinding.ensureInitialized();

  SystemChrome.setSystemUIOverlayStyle(const SystemUiOverlayStyle(
    statusBarColor: Colors.transparent, // Couleur de fond de la barre d'état
    statusBarIconBrightness: Brightness.dark, // Pour des icônes noires sur fond clair
  ));

  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => EntryPointController(AuthService())),
        ChangeNotifierProvider(create: (_) => AuthController(authService: AuthService())),
        ChangeNotifierProvider(create: (_) => MeController()),
      ],
      child: EntryPointView()
    ),
  );
}


