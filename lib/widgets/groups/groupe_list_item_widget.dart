import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:projet_picsou/controllers/friends/friend_widget_controller.dart';
import 'package:projet_picsou/core/theme/app_theme.dart';
import 'package:projet_picsou/core/custom_navigator.dart';
import 'package:projet_picsou/views/user_profile_view.dart';
import 'package:projet_picsou/widgets/ui/button_widget.dart';
import 'package:provider/provider.dart';

import '../../models/group.dart';
import '../../models/user.dart';

class GroupeListItemWidget extends StatelessWidget {
  final Group group;

  const GroupeListItemWidget({
    super.key,
    required this.group,
  });

  @override
  Widget build(BuildContext context) {
    final controller = context.watch<FriendWidgetController>();
    return GestureDetector(
      onTap: () {
        HapticFeedback.mediumImpact();
      },
      child: Container(
        padding: EdgeInsets.all(15),
        child: Row(
          mainAxisSize: MainAxisSize.max,
          children: [
            Expanded(
              child: Row(
                mainAxisSize: MainAxisSize.max,
                children: [
                  Hero(
                      tag: "${group.id}_profile_picture",
                      child: Image.network(group.pictRef, width: 70, height: 70)
                  ),
                  SizedBox(width: 15),
                  Text(
                    textAlign: TextAlign.center,
                    style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                    ),
                    group.name,
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
