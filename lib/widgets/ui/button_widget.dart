import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:projet_picsou/core/theme/app_theme.dart';

import '../../core/theme/app_theme.dart' as app_theme;

enum ButtonWidgetSize {
  small(10.0),
  medium(20.0),
  large(30.0);

  final double value;

  const ButtonWidgetSize(this.value);
}

class ButtonWidget extends StatelessWidget {
  final String message;
  final IconData icon;
  final Color backgroundColor;
  final Color foregroundColor;
  final VoidCallback onPressed;
  final EdgeInsetsGeometry padding;

  const ButtonWidget({
    super.key,
    required this.message,
    required this.icon,
    this.foregroundColor = app_theme.backgroundColor,
    this.backgroundColor = primaryColor,
    required this.onPressed,
    this.padding = const EdgeInsets.symmetric(vertical: 10, horizontal: 15),
  });

  @override
  Widget build(BuildContext context) {
    return ElevatedButton.icon(
      style: ElevatedButton.styleFrom(
        backgroundColor: backgroundColor,
        foregroundColor: foregroundColor,
        elevation: 4,
        shadowColor: primaryColor.withAlpha((0.3 * 255).round()),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(24),
        ),
        padding: padding,
        textStyle: const TextStyle(
          fontWeight: FontWeight.w600,
          fontSize: 16,
          fontFamily: 'Poppins',
        ),
      ),
      icon: Icon(icon, size: 22),
      label: Text(message),
      onPressed: () {
        HapticFeedback.mediumImpact();
        onPressed();
      }
    );
  }
}