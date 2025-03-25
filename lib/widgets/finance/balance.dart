import 'package:flutter/material.dart';

import '../../controllers/expense_controller.dart';

class Balance extends StatelessWidget {
  Balance({super.key});

  final expenseController = ExpenseController();

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<double>(
      future: expenseController.getUserBalance(),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return CircularProgressIndicator();
        } else if (snapshot.hasData) {
          return Text(
              style: TextStyle(
                  fontWeight: FontWeight.w900,
                  fontSize: 40
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