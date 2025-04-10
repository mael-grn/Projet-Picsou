import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:projet_picsou/views/register_view.dart';
import '../../core/theme/app_theme.dart';

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
            child: Center(
              child: Padding(
                padding: EdgeInsets.all(30),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Image.asset("images/exchange_money.png"),
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
                  ],
                ),
              ),
            ),
          ),
        ),
      ),

      floatingActionButton: FloatingActionButton.large(
        onPressed:()  {
          HapticFeedback.heavyImpact();
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => RegisterView(),
            ),
          );
        },
        elevation: 7,
        hoverElevation: 0,
        backgroundColor: foregroundColor,
        hoverColor: foregroundVariantColor,
        child: Icon(
            color: backgroundColor,
            Icons.arrow_forward
        ),
      ),
    );
  }
}
