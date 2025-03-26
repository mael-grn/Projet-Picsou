import 'package:flutter/material.dart';
import 'package:projet_picsou/controllers/payment_controller.dart';
import '../../core/theme/app_theme.dart';
import 'package:shimmer/shimmer.dart';

/// Widget to display the global balance of the user.
class BalanceWidget extends StatelessWidget {
  BalanceWidget({super.key});

  final paymentController = PaymentController();

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<double>(
      future: paymentController.getUserBalance(),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return Shimmer.fromColors(
            baseColor: primaryDarkColor, // Couleur de base
            highlightColor: primaryLightColor, // Couleur en surbrillance
            child: Container(
              width: 200,
              height: 57, // Taille du bloc
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10),
                color: primaryDarkColor, // Même couleur que baseColor
              ),
            ),
          );
        } else if (snapshot.hasData) {
          return Text(
              style: TextStyle(
                  fontWeight: FontWeight.w800,
                  fontSize: 40,
                  color: foregroundColor
              ),
              snapshot.data! > 0 ? '+ ${snapshot.data} €' : '${snapshot.data} €'
          );
        } else {
          return Text('Erreur de chargement');
        }
      },
    );
  }
}