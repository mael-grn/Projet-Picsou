import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:projet_picsou/core/theme/app_theme.dart';
import 'package:shimmer/shimmer.dart';

class ConversationButtonLoading extends StatelessWidget {

  const ConversationButtonLoading({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        SizedBox(height: 5),
        Container(
          padding: EdgeInsets.fromLTRB(15, 20, 15, 20),
            child: Row(
              children: [
                Shimmer.fromColors(
                  baseColor: primaryDarkColor,
                  highlightColor: primaryLightColor,
                  child: Container(
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(100),
                      color: primaryDarkColor,
                    ),
                    clipBehavior: Clip.antiAlias,
                    width: 60,
                    height: 60,
                  )
                ),
                SizedBox(width: 10),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Shimmer.fromColors(
                        baseColor: primaryDarkColor,
                        highlightColor: primaryLightColor,
                        child: Container(
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(10),
                            color: primaryDarkColor,
                          ),
                          clipBehavior: Clip.antiAlias,
                          width: 100,
                          height: 30,
                        )
                    ),
                    Shimmer.fromColors(
                        baseColor: primaryDarkColor,
                        highlightColor: primaryLightColor,
                        child: Container(
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(10),
                            color: primaryDarkColor,

                          ),
                          clipBehavior: Clip.antiAlias,
                          width: 200,
                          height: 25,
                        )
                    ),
                  ],
                ),
              ],
            )
        )
      ],
    ) ;
  }
}