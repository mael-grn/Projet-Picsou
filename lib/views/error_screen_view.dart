import 'package:flutter/material.dart';
import 'package:projet_picsou/core/theme/app_theme.dart';
import 'package:projet_picsou/views/troubleshooting_view.dart';
import 'package:projet_picsou/widgets/animations/slide_up_animation_widget.dart';
import 'package:projet_picsou/widgets/ui/button_widget.dart';
import 'package:restart_app/restart_app.dart';

import '../core/PageRoute.dart';
import '../widgets/animations/scale_animation_widget.dart';

class ErrorScreenView extends StatelessWidget {
  final String errorMessage;
  final String image;
  const ErrorScreenView({required this.errorMessage,this.image = "images/broken_server.png", super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SizedBox(
        width: double.infinity,
        height: double.infinity,
        child: Container(
          color: backgroundColor,
          child: Center(
              child: Padding(
                  padding: EdgeInsets.all(20),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [

                      ScaleAnimationWidget(
                        child: Image.asset(
                          image,
                          width: double.infinity,
                          fit: BoxFit.contain,
                          height: 300,
                        ),
                      ),
                      SizedBox(height: 30),
                      SlideUpAnimationWidget(
                          child: Text(
                              style: TextStyle(
                                  fontSize: 35,
                                  fontWeight: FontWeight.bold
                              ),
                              textAlign: TextAlign.center,
                              "Zut, quelque chose semble avoir mal tourné"
                          ),
                      ),
                      SizedBox(height: 15),
                      SlideUpAnimationWidget(
                        duration: Duration(milliseconds: 1500),
                          child: Text(
                              textAlign: TextAlign.center,
                              errorMessage
                          ),
                      ),
                      SizedBox(height: 50),
                      ButtonWidget(
                        message: "Redémarrer l'application",
                        icon: Icons.refresh,
                        onPressed: () {
                          Restart.restartApp();
                        },
                      ),
                      SizedBox(height: 15),
                      ButtonWidget(
                        tag: "troubleshooting",
                        backgroundColor: backgroundVariantColor,
                        foregroundColor: foregroundColor,
                        message: "Résolution de problèmes",
                        icon: Icons.info_outline,
                        onPressed: () {
                          PageRouter.push(TroubleshootingView());
                        },
                      )

                    ],
                  )
              )
          ),
        ),
      ),
    );
  }
}
