import 'package:flutter/material.dart';
import 'package:projet_picsou/widgets/animations/scale_animation_widget.dart';
import 'package:projet_picsou/widgets/ui/popup_page_widget.dart';
import '../core/custom_navigator.dart';
import '../models/user.dart';
import '../widgets/ui/button_widget.dart';
import '../widgets/ui/text_info_widget.dart';
import 'edit_paiement_data_view.dart';

class PaiementDataView extends StatelessWidget {
  const PaiementDataView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: PopupPageWidget(
            title: "Mes données de paiement",
            body: Column(
              children: [

                SizedBox(height: 40),
                SizedBox(
                  width: double.infinity,
                  child: Center(
                    child: ScaleAnimationWidget(
                      child: Image.asset(width: 150, "images/credit_card.png"),
                    ),
                  )
                ),

                SizedBox(height: 40),

                TextInfoWidget(
                  "Paypal :",
                  User.getCurrentUserInstance()
                      .emailPaypal,
                ),
                Divider(
                  thickness: 1,
                  color: Colors.grey,
                  height: 50,
                ),
                TextInfoWidget(
                  "Wero :",
                  User.getCurrentUserInstance().telWero,
                ),
                Divider(
                  thickness: 1,
                  color: Colors.grey,
                  height: 50,
                ),
                TextInfoWidget(
                  "Rib :",
                  User.getCurrentUserInstance().rib,
                ),

                SizedBox(height: 40),

                ButtonWidget(
                  message: "Modifier",
                  icon: Icons.edit,
                  onPressed: () {
                    CustomNavigator.pushFromRight(EditPaiementDataView());
                  },
                ),
              ],
            )
        )
    );
  }
}
