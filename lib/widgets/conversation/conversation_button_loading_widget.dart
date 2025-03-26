import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:projet_picsou/core/theme/app_theme.dart';
import 'package:shimmer/shimmer.dart';

/// The purpose of this widget is only to show the "ghost" of a conversation while it is being loaded
class ConversationButtonLoadingWidget extends StatelessWidget {

  const ConversationButtonLoadingWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        SizedBox(height: 5),
        Container(
          padding: EdgeInsets.fromLTRB(15, 5, 15, 5),
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
                          height: 25,
                        )
                    ),
                    SizedBox(height: 3),
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
                          height: 15,
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