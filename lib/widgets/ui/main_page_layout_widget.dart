import 'package:flutter/material.dart';
import 'package:projet_picsou/core/theme/app_theme.dart';
import '../animations/slide_up_animation_widget.dart';

class MainPageLayoutWidget extends StatelessWidget {
  final Widget groundFloor;
  final Widget firstFloor;
  final Widget secondFloor;

  const MainPageLayoutWidget({
    super.key,
    required this.groundFloor,
    required this.firstFloor,
    required this.secondFloor,
  });

  @override
  Widget build(BuildContext context) {

    return Container(
      width: double.infinity,
      color: primaryColor,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          Padding(
            padding: EdgeInsets.fromLTRB(15, 75, 15, 20),
            child: secondFloor,
          ),
          
          Expanded(
            child: SlideUpAnimationWidget(
              child: Container(
                width: double.infinity,
                decoration: BoxDecoration(
                  borderRadius: const BorderRadius.only(
                    topLeft: Radius.circular(40),
                    topRight: Radius.circular(40),
                  ),
                  color: backgroundVariantColor,
                ),
                child: Column(
                  children: [
                    Padding(
                      padding: EdgeInsets.fromLTRB(15, 20, 15, 20),
                      child: firstFloor,
                    ),
                    Expanded(
                      child: SlideUpAnimationWidget(
                        duration: Duration(milliseconds: 1000),
                        child: Container(
                          width: double.infinity,
                          padding: EdgeInsets.fromLTRB(15, 0, 15, 0),
                          decoration: BoxDecoration(
                            borderRadius: const BorderRadius.only(
                              topLeft: Radius.circular(40),
                              topRight: Radius.circular(40),
                            ),
                            color: backgroundColor,
                          ),
                          child: groundFloor,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}