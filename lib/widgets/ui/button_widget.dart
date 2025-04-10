import 'package:flutter/material.dart';
import 'package:projet_picsou/core/theme/app_theme.dart';

class ButtonWidget extends StatelessWidget {

  final String? message;
  final IconData? icon;
  final Color? backgroundColor;
  final Color? textColor;
  final VoidCallback onPressed;

  const ButtonWidget({super.key, this.message, this.icon, this.backgroundColor, this.textColor, required this.onPressed });

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      style: ButtonStyle(
        backgroundColor: WidgetStatePropertyAll(backgroundColor ?? foregroundColor),
        foregroundColor:  WidgetStatePropertyAll(textColor ?? backgroundColor),
      ),
      onPressed: onPressed,
      child: Padding(
          padding: EdgeInsets.fromLTRB(10, 20, 10, 20),
        child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [


              if (message != null)
                Text(
                    message!,
                    style: TextStyle(
                      color: textColor,
                      fontSize: 20,
                    )
                ),
              if (icon != null && message != null)
                SizedBox(width: 10),
              if (icon != null)
                Icon(
                  size: 30,
                  icon,
                  color: textColor,
                ),
            ]
        ),
      )
    );
  }
}
