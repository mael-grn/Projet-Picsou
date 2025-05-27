import 'package:flutter/material.dart';
import 'package:projet_picsou/widgets/ui/popup_page_widget.dart';

import '../core/theme/custom_navigator.dart';
import '../models/user.dart';
import '../widgets/ui/button_widget.dart';
import '../widgets/ui/text_info_widget.dart';
import 'edit_personal_data_view.dart';

class PersonalDataView extends StatelessWidget {
  const PersonalDataView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: PopupPageWidget(
            title: "Mes données personnelles",
            body: Column(
              children: [
                Hero(
                  tag: User.getCurrentUserInstance().profilPictureRef,
                  child: Image.network(
                    User.getCurrentUserInstance().profilPictureRef,
                    width: 200,
                    height: 200,
                  ),
                ),

                SizedBox(height: 40),

                TextInfoWidget(
                  "Prénom :",
                  User.getCurrentUserInstance().firstName,
                ),
                Divider(
                  thickness: 1,
                  color: Colors.grey,
                  height: 50,
                ),
                TextInfoWidget(
                  "Nom :",
                  User.getCurrentUserInstance().lastName,
                ),
                Divider(
                  thickness: 1,
                  color: Colors.grey,
                  height: 50,
                ),
                TextInfoWidget(
                  "Email :",
                  User.getCurrentUserInstance().email,
                ),
                Divider(
                  thickness: 1,
                  color: Colors.grey,
                  height: 50,
                ),
                TextInfoWidget(
                  "Téléphone :",
                  User.getCurrentUserInstance().tel,
                ),

                SizedBox(height: 40),

                ButtonWidget(
                  message: "Modifier",
                  tag: "edit_user",
                  icon: Icons.edit,
                  onPressed: () {
                    CustomNavigator.push(EditPersonalDataView());
                  },
                ),
              ],
            )
        )
    );
  }
}
