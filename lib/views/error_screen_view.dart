import 'package:flutter/material.dart';
import 'package:projet_picsou/core/theme/app_theme.dart';

class ErrorScreenView extends StatelessWidget {
  final String errorMessage;
  const ErrorScreenView(this.errorMessage, {super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SizedBox(
        width: double.infinity,
        height: double.infinity,
        child: Container(
          color: backgroundColor,
          child: Center(
              child: Text(errorMessage)
          ),
        ),
      ),
    );
  }
}
