import 'package:flutter/material.dart';
import 'package:projet_picsou/views/register_view.dart';
import 'package:projet_picsou/widgets/animations/scale_animation_widget.dart';
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
                ScaleAnimationWidget(
                  child: Image.asset("images/rich.png", height: 300),
                ),
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
                  tag: "validate_button",
                  onPressed: () {
                    CustomNavigator.push(RegisterView());
                  },
                  message: "Commencer l'aventure",
                  icon: Icons.arrow_forward,
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
