import 'package:flutter/material.dart';
import 'package:projet_picsou/core/theme/app_theme.dart';

enum ButtonWidgetSize {
  small(10.0),
  medium(20.0),
  large(30.0);

  final double value;

  const ButtonWidgetSize(this.value);
}

class ButtonWidget extends StatelessWidget {
  final String? message;
  final IconData? icon;
  final Color? buttonBackgroundColor;
  final Color? textColor;
  final ButtonWidgetSize size;
  final VoidCallback onPressed;

  const ButtonWidget({
    super.key,
    this.message,
    this.icon,
    this.buttonBackgroundColor,
    this.textColor,
    this.size = ButtonWidgetSize.medium,
    required this.onPressed,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        Row(
          mainAxisSize: MainAxisSize.min,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            ElevatedButton(
              style: ButtonStyle(
                backgroundColor: WidgetStatePropertyAll(
                  buttonBackgroundColor ?? foregroundColor,
                ),
                foregroundColor: WidgetStatePropertyAll(
                  textColor ?? backgroundColor,
                ),
              ),
              onPressed: onPressed,
              child: Padding(
                padding: EdgeInsets.all(size.value / 2),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    if (message != null)
                      Text(
                        message!,
                        style: TextStyle(
                          color: textColor ?? backgroundColor,
                          fontSize: size.value,
                        ),
                      ),
                    if (icon != null && message != null) SizedBox(width: 10),
                    if (icon != null)
                      Icon(
                        size: size.value,
                        icon,
                        color: textColor ?? backgroundColor,
                      ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ],
    );
  }
}
