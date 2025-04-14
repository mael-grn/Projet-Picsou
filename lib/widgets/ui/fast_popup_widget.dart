import 'package:flutter/material.dart';
import 'package:projet_picsou/widgets/ui/popup_widget.dart';

import 'button_widget.dart';

class FastPopupWidget extends StatelessWidget {
  final bool show;
  final Function? onClosePressed;
  final String title;
  final String content;
  final String? imageSrc;
  final List<ButtonWidget>? buttons;
  final bool showCloseButton;

  const FastPopupWidget({
    required this.title,
    required this.content,
    required this.show,
    this.onClosePressed,
    this.imageSrc,
    this.buttons,
    this.showCloseButton = true,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return PopupWidget(
      show: show,
      onClosePressed: onClosePressed,
      showCloseButton: showCloseButton,
      children: [
        SizedBox(height: 100),
        if (imageSrc != null)
          Image.asset(
            imageSrc!,
            width: 200,
            fit: BoxFit.contain,
            height: 200,
          ),
        SizedBox(height: 20),
        Text(
          textAlign: TextAlign.center,
          style: TextStyle(
            fontSize: 40,
            fontWeight: FontWeight.bold,
          ),
          title,
        ),
        SizedBox(height: 10),
        Text(textAlign: TextAlign.center, content),
        if (buttons != null)
          ...buttons!
      ]
    );
  }
}
