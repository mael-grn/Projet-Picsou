import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:projet_picsou/controllers/friends/friend_widget_controller.dart';
import 'package:projet_picsou/core/theme/app_theme.dart';
import 'package:projet_picsou/core/custom_navigator.dart';
import 'package:projet_picsou/views/user_profile_view.dart';
import 'package:projet_picsou/widgets/ui/button_widget.dart';
import 'package:provider/provider.dart';

import '../../models/user.dart';

class FriendWidget extends StatelessWidget {
  final User user;
  final int friendId;

  const FriendWidget({
    super.key,
    required this.friendId,
    required this.user,
  });

  @override
  Widget build(BuildContext context) {
    final controller = context.watch<FriendWidgetController>();
    return GestureDetector(
      onTap: () {
        HapticFeedback.mediumImpact();
        CustomNavigator.pushFromRight(
          UserProfileView(
              user: user,
            showSensitive: true,
            actions: [
              ButtonWidget(
                message: "Supprimer l'amis",
                icon: Icons.delete,
                backgroundColor: invalidColor,
                onPressed: () {
                  HapticFeedback.mediumImpact();
                  controller.deleteFriend(friendId);
                },
              ),
            ],
          ),
          otherContext: context,
        );
      },
      child: Container(
        decoration: BoxDecoration(
            color: backgroundVariantColor,
            borderRadius: BorderRadius.circular(20)
        ),
        padding: EdgeInsets.all(15),
        child: Row(
          mainAxisSize: MainAxisSize.max,
          children: [
            Expanded(
              child: Row(
                mainAxisSize: MainAxisSize.max,
                children: [
                  Hero(
                      tag: "${user.id}_profile_picture",
                      child: Image.network(user.profilPictureRef, width: 75, height: 75)
                  ),
                  SizedBox(width: 15),
                  Text(
                    textAlign: TextAlign.center,
                    style: TextStyle(fontSize: 20),
                    "${user.firstName} ${user.lastName}",
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
