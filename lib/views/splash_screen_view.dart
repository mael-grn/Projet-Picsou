import 'package:flutter/material.dart';

import '../core/theme/app_theme.dart';

class SplashScreenView extends StatelessWidget {
  const SplashScreenView({super.key});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SizedBox(
        width: double.infinity,
        height: double.infinity,
        child: Container(
          color: backgroundColor,
          child: Center(
              child: Text("Bienvenue sur Picsou!")
          ),
        ),
      ),
    );
  }
}