import 'package:flutter/material.dart';
import 'package:projet_picsou/core/theme/app_theme.dart';
import 'package:projet_picsou/widgets/ui/button_widget.dart';

import '../../core/theme/custom_navigator.dart';

class PopupPageWidget extends StatelessWidget {
  final String title;
  final Widget body;
  final String? closeButtonTag;
  const PopupPageWidget({required this.title, required this.body, this.closeButtonTag, super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SizedBox(
        width: double.infinity,
        height: double.infinity,
        child: Container(
            color: backgroundColor,
            child: Stack(
              children: [
                Padding(
                  padding: EdgeInsets.fromLTRB(20, 0, 20, 0),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Expanded(
                        child: SingleChildScrollView(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              SizedBox(height: 100),
                              Text(
                                title,
                                style: TextStyle(
                                  fontSize: 45,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              SizedBox(height: 45),
                              body,
                              SizedBox(height: 100),
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                Positioned(
                  left: 20,
                  right: 20,
                  bottom: 30,
                  child: ButtonWidget(
                    tag: closeButtonTag ?? "button-$title",
                    backgroundColor: foregroundVariantColor,
                    message: "Fermer",
                    icon: Icons.close,
                    onPressed: () {
                      CustomNavigator.back();
                    },
                  ),
                )
              ],
            )
        ),
      ),
    );
  }
}
