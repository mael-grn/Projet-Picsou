import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:projet_picsou/views/register_view.dart';
import '../../core/theme/app_theme.dart';
import '../core/PageRoute.dart';
import '../widgets/ui/button_widget.dart';

class SplashScreenView extends StatelessWidget {
  const SplashScreenView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SizedBox(
        width: double.infinity,
        height: double.infinity,
        child: Center(
          child: Padding(
            padding: EdgeInsets.all(30),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Image.asset(height: 300, "images/rich.png"),
                SizedBox(height: 20),
                Text(
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: 40,
                    fontWeight: FontWeight.bold,
                  ),
                  "Bienvenu sur Picsou !",
                ),
                SizedBox(height: 10),
                Text(
                  textAlign: TextAlign.center,
                  "Simplifiez la gestion de vos dépenses avec vos amis, colocataires, collègues, bref, n’importe qui.",
                ),
                SizedBox(height: 30),
                ButtonWidget(
                  onPressed: () {
                    Navigator.of(
                      context,
                    ).push(DefaultPageRoute(builder: (_) => RegisterView()));
                  },
                  message: "Commencer l'aventure",
                  icon: Icons.arrow_forward,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
