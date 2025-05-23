import 'package:flutter/material.dart';
import 'package:projet_picsou/widgets/animations/slide_fade_animation_widget.dart';
import 'package:restart_app/restart_app.dart';
import '../models/user.dart';
import '../widgets/ui/button_widget.dart';

class WelcomScreenView extends StatefulWidget {
  WelcomScreenView({super.key});
  @override
  _WelcomScreenViewState createState() => _WelcomScreenViewState();
}

class _WelcomScreenViewState extends State<WelcomScreenView>{

  @override
  Widget build(BuildContext context) {

    return Scaffold(
      body: Container(
        width: double.infinity,
        height: double.infinity,
        padding: EdgeInsets.fromLTRB(30, 0, 30, 0),
        child: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                SizedBox(height: 20),
                Hero(
                  tag: User.getCurrentUserInstance().profilPictureRef,
                  child: Image.network(
                    User.getCurrentUserInstance().profilPictureRef,
                    width: 200,
                    height: 200,
                    fit: BoxFit.cover,
                  ),
                ),
                SizedBox(height: 30),
                SlideFadeAnimationWidget(
                  duration: Duration(milliseconds: 1500),
                  child: Text(
                    textAlign: TextAlign.center,
                    style: TextStyle(fontWeight: FontWeight.w600, fontSize: 35),
                    "Bienvenue, ${User.getCurrentUserInstance().firstName} !",
                  ),
                ),
                SizedBox(height: 20),
                SlideFadeAnimationWidget(
                  duration: Duration(milliseconds: 2000),
                  child: Text(
                    textAlign: TextAlign.center,
                    "L'équipe Picsou est ravie de vous accueillir !",
                  ),
                ),
                SizedBox(height: 40),
                ButtonWidget(
                  onPressed: () {
                    Restart.restartApp();
                  },
                  tag: "validate_button",
                  message: "Commencer",
                  icon: Icons.rocket_launch,
                ),
                SizedBox(height: 20),
              ],
            )
        ),
      ),
    );
  }

}