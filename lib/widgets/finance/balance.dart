import 'package:flutter/material.dart';
import '../../controllers/expense_controller.dart';
import '../../core/theme/app_theme.dart';
import 'package:shimmer/shimmer.dart';

class Balance extends StatelessWidget {
  Balance({super.key});

  final expenseController = ExpenseController();

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<double>(
      future: expenseController.getUserBalance(),
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
                  fontWeight: FontWeight.w900,
                  fontSize: 40,
                  color: foregroundColor
              ),
              '${snapshot.data} €'
          );
        } else {
          return Text('Erreur de chargement');
        }
      },
    );
  }
}