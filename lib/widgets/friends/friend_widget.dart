import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:projet_picsou/core/theme/app_theme.dart';
import 'package:projet_picsou/core/custom_navigator.dart';
import 'package:projet_picsou/views/user_profile_view.dart';
import 'package:projet_picsou/widgets/ui/button_widget.dart';

import '../../models/user.dart';

class FriendWidget extends StatelessWidget {
  final User user;

  const FriendWidget({
    super.key,
    required this.user,
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
        ],
      ),
    );
  }
}
