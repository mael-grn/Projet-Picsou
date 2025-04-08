import 'package:flutter/material.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';
import 'package:projet_picsou/core/theme/app_theme.dart';

class LoadingSceenView extends StatelessWidget {
  const LoadingSceenView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SizedBox(
        width: double.infinity,
        height: double.infinity,
        child: Container(
          color: backgroundColor,
          child: Center(
            child: LoadingAnimationWidget.inkDrop(
              color: foregroundColor,
              size: 30,
            ),
          ),
        ),
      )
    );
  }
}
