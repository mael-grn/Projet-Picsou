import 'package:flutter/material.dart';
import 'package:projet_picsou/widgets/ui/popup_page_widget.dart';

import '../core/custom_navigator.dart';
import '../models/user.dart';
import '../widgets/ui/button_widget.dart';
import '../widgets/ui/text_info_widget.dart';
import 'edit_personal_data_view.dart';

class UserProfileView extends StatelessWidget {
  final User user;
  const UserProfileView({required this.user, super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: PopupPageWidget(
            body: Column(
              children: [
                Hero(
                    tag: "${user.id}_profile_picture",
                    child: Image.network(
                      user.profilPictureRef,
                      width: 200,
                      height: 200,
                    ),
                ),

                SizedBox(height: 20),

                Text(
                  textAlign: TextAlign.center,
                  "${user.firstName} ${user.lastName}",
                  style: TextStyle(
                    fontSize: 45,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                SizedBox(height: 20),
                Divider(
                  thickness: 1,
                  color: Colors.grey,
                  height: 25,
                ),
                TextInfoWidget(
                  "Email :",
                  user.email,
                ),
                Divider(
                  thickness: 1,
                  color: Colors.grey,
                  height: 25,
                ),
                TextInfoWidget(
                  "Téléphone :",
                  user.tel,
                ),

                SizedBox(height: 40),

                Row(
                  children: [
                    Image.asset(width: 50, "images/credit_card.png"),
                    SizedBox(width: 20),
                    Expanded(
                      child: Text(
                        "Voici les manière dont vous pouvez rembourser ${user.firstName}",
                        textAlign: TextAlign.start,
                        style: TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ],
                ),
                SizedBox(height: 20),

                Divider(
                  thickness: 1,
                  color: Colors.grey,
                  height: 25,
                ),
                TextInfoWidget(
                  "Paypal :",
                  user.emailPaypal,
                ),
                Divider(
                  thickness: 1,
                  color: Colors.grey,
                  height: 25,
                ),
                TextInfoWidget(
                  "Wero :",
                  user.telWero,
                ),
                Divider(
                  thickness: 1,
                  color: Colors.grey,
                  height: 25,
                ),
                TextInfoWidget(
                  "Rib :",
                  user.rib,
                ),
              ],
            )
        )
    );
  }
}
