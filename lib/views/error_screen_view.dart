import 'package:flutter/material.dart';
import 'package:projet_picsou/core/theme/app_theme.dart';
import 'package:projet_picsou/widgets/ui/button_widget.dart';
import 'package:restart_app/restart_app.dart';

class ErrorScreenView extends StatelessWidget {
  final String errorMessage;
  final String image;
  const ErrorScreenView({required this.errorMessage,this.image = "images/wondering.png", super.key});

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

                      Image.asset(
                        "images/wondering.png",
                        width: double.infinity,
                        fit: BoxFit.contain,
                        height: 400,
                      ),
                      SizedBox(height: 20),
                      Text(
                          textAlign: TextAlign.center,
                          errorMessage
                      ),
                      SizedBox(height: 20),
                      ButtonWidget(
                        message: "Redemarrer l'application",
                        icon: Icons.refresh,
                        backgroundColor: foregroundVariantColor,
                        foregroundColor: backgroundColor,
                        onPressed: () {
                          Restart.restartApp();
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
