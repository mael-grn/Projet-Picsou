import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:projet_picsou/core/theme/app_theme.dart';
import 'package:projet_picsou/core/custom_navigator.dart';
import 'package:projet_picsou/views/user_profile_view.dart';
import 'package:projet_picsou/widgets/ui/button_widget.dart';

import '../../models/user.dart';

class FriendRequestWidget extends StatelessWidget {
  final User user;
  final Function? onAccept;
  final Function onDecline;

  const FriendRequestWidget({
    super.key,
    required this.user,
    this.onAccept,
    required this.onDecline,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(borderRadius: BorderRadius.circular(20)),
      padding: EdgeInsets.all(5),
      child: Row(
        mainAxisSize: MainAxisSize.max,
        children: [
          Expanded(
            child: GestureDetector(
              onTap: () {
                HapticFeedback.mediumImpact();
                CustomNavigator.pushFromRight(
                  UserProfileView(user: user),
                  otherContext: context,
                );
              },
              child: Row(
                mainAxisSize: MainAxisSize.max,
                children: [
                  Hero(
                      tag: "${user.id}_profile_picture",
                      child: Image.network(user.profilPictureRef, width: 40, height: 40)
                  ),
                  SizedBox(width: 15),
                  Text(
                    textAlign: TextAlign.center,
                    style: TextStyle(fontSize: 15),
                    "${user.firstName} ${user.lastName}",
                  ),
                ],
              ),
            ),
          ),

          IconButton(
            icon: Icon(Icons.close, color: invalidColor),
            onPressed: () {
              HapticFeedback.mediumImpact();
              onDecline();
            },
          ),

          if (onAccept != null) SizedBox(width: 10),
          if (onAccept != null)
            IconButton(
              icon: Icon(Icons.check, color: validColor),
              onPressed: () {
                HapticFeedback.mediumImpact();
                if (onAccept != null) {
                  onAccept!();
                }
              },
            ),
        ],
      ),
    );
  }
}
