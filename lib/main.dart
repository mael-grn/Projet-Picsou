import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:projet_picsou/services/auth_service.dart';
import 'package:projet_picsou/utils/token_utils.dart';
import 'package:projet_picsou/views/splash_screen_view.dart';
import 'package:projet_picsou/widgets/global_layout.dart';
import 'package:provider/provider.dart';
import 'controllers/auth_controller.dart';
import 'core/theme/app_theme.dart';

void main() async {

  WidgetsFlutterBinding.ensureInitialized();

  SystemChrome.setSystemUIOverlayStyle(const SystemUiOverlayStyle(
    statusBarColor: Colors.transparent, // Couleur de fond de la barre d'état
    statusBarIconBrightness: Brightness.dark, // Pour des icônes noires sur fond clair
  ));

  //Création de l'instance du controller d'authentification
  final authController = AuthController(authService: AuthService());

  //Verification du token
  await authController.loadUser();

  print(await TokenUtils.loadToken());
  //Determiner le premier widget de l'app
  Widget entryPoint;
  if (authController.user != null) {
    print(authController.user?.lastName);
    entryPoint = GlobalLayout();
  } else {
    print("Pas de token");
    entryPoint = SplashScreenView();
  }

  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => authController),
      ],
      child: MaterialApp(
        title: 'PICSOU',
        debugShowCheckedModeBanner: false,
        home: entryPoint,
        theme: appTheme,
      ),
    ),
  );
}


