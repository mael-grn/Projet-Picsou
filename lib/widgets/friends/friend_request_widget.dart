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
      decoration: BoxDecoration(
          color: backgroundVariantColor,
          borderRadius: BorderRadius.circular(20)
      ),
      padding: EdgeInsets.all(10),
      child: Row(
        mainAxisSize: MainAxisSize.max,
        children: [
          Expanded(
            child: GestureDetector(
              onTap: () {
                HapticFeedback.mediumImpact();
                CustomNavigator.pushFromRight(
                  UserProfileView(
                    user: user,
                    showSensitive: false,
                    actions: [
                      ButtonWidget(
                        message: "Supprimer la demande",
                        icon: Icons.delete,
                        backgroundColor: invalidColor,
                        onPressed: () {
                          HapticFeedback.mediumImpact();
                          onDecline();
                          CustomNavigator.back();
                        },
                      ),
                      if (onAccept != null) SizedBox(width: 10),
                      if (onAccept != null)
                        ButtonWidget(
                          message: "Accepter la demande",
                          icon: Icons.check,
                          onPressed: () {
                            HapticFeedback.mediumImpact();
                            if (onAccept != null) {
                              onAccept!();
                              CustomNavigator.back();
                            }
                          },
                        )

                    ],
                  ),
                  otherContext: context,
                );
              },
              child: Row(
                mainAxisSize: MainAxisSize.max,
                children: [
                  Hero(
                      tag: "${user.id}_profile_picture",
                      child: Image.network(user.profilPictureRef, width: 50, height: 50)
                  ),
                  SizedBox(width: 15),
                  Text(
                    textAlign: TextAlign.center,
                    style: TextStyle(fontSize: 17),
                    "${user.firstName} ${user.lastName}",
                  ),
                ],
              ),
            ),
          ),

          Container(
            decoration: BoxDecoration(
              color: invalidColor,
              shape: BoxShape.circle,
            ),
            child: IconButton(
              icon: Icon(Icons.close, color: backgroundColor),
              onPressed: () {
                HapticFeedback.mediumImpact();
                onDecline();
              },
            ),

          ),

          if (onAccept != null) SizedBox(width: 10),
          if (onAccept != null)
            Container(
              decoration: BoxDecoration(
                color: validColor,
                shape: BoxShape.circle,
              ),
              child: IconButton(
                icon: Icon(Icons.check, color: backgroundColor),
                onPressed: () {
                  HapticFeedback.mediumImpact();
                  if (onAccept != null) {
                    onAccept!();
                  }
                },
              ),
            )
        ],
      ),
    );
  }
}
