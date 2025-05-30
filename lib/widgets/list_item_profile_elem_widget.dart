import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:projet_picsou/core/theme/app_theme.dart';
import 'package:projet_picsou/core/custom_navigator.dart';
import 'package:projet_picsou/utils/string_utils.dart';
import 'package:projet_picsou/views/user_profile_view.dart';
import 'package:projet_picsou/widgets/ui/button_widget.dart';
import 'package:provider/provider.dart';

import '../../models/group.dart';
import '../../models/user.dart';

class ListItemProfileElemWidget extends StatelessWidget {
  final String imageUrl;
  final int id;
  final String name;
  final Color color;
  final Function? onTap;
  final bool addGapAfter;
  final bool showTag;

  const ListItemProfileElemWidget({
    super.key,
    required this.id,
    required this.imageUrl,
    required this.name,
    this.onTap,
    this.color = backgroundColor,
    this.addGapAfter = true,
    this.showTag = true
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        GestureDetector(
          onTap: () {
            if (onTap != null) {
              HapticFeedback.mediumImpact();
              onTap!();
            }
          },
          child: Container(
            decoration: BoxDecoration(
              color: color,
              borderRadius: BorderRadius.circular(25),
            ),
            padding: EdgeInsets.all(10),
            child: Row(
              mainAxisSize: MainAxisSize.max,
              children: [
                Expanded(
                  child: Row(
                    mainAxisSize: MainAxisSize.max,
                    children: [
                      Hero(
                        tag: showTag ? "${id}_pp" : CustomStringUtils.generateRandomString(20),
                        child: Image.network(imageUrl, width: 70, height: 70),
                      ),
                      SizedBox(width: 15),
                      Text(
                        textAlign: TextAlign.center,
                        style: TextStyle(fontSize: 20),
                        name,
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
        if (addGapAfter) SizedBox(height: 10),
      ],
    );
  }
}
