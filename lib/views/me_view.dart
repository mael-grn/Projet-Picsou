import 'package:flutter/material.dart';
import 'package:projet_picsou/core/theme/app_theme.dart';
import 'package:projet_picsou/models/user.dart';
import 'package:projet_picsou/dialogs/alert_dialog_builder.dart';
import 'package:provider/provider.dart';
import '../controllers/me_controller.dart';
import '../core/PageRoute.dart';
import '../widgets/ui/button_widget.dart';
import '../widgets/ui/main_page_layout_widget.dart';
import 'edit_personal_data_view.dart';

class MeView extends StatefulWidget {
  const MeView({super.key});

  @override
  _MeViewState createState() => _MeViewState();
}

class _MeViewState extends State<MeView>{

  @override
  Widget build(BuildContext context) {
    final meController = context.watch<MeController>();

    return MainPageLayoutWidget(
      secondFloor: Text(
        "${User.getCurrentUserInstance().firstName} ${User.getCurrentUserInstance().lastName}",
        overflow: TextOverflow.ellipsis, // Ajout de l'overflow
        maxLines: 1,
        textAlign: TextAlign.start,
        style: TextStyle(fontWeight: FontWeight.w600, fontSize: 35),
      ),

      firstFloor: Row(
        children: [
          Expanded(
            child: ButtonWidget(
              message: "Modifier",
              tag: "edit_user",
              icon: Icons.edit,
              onPressed: () {
                Navigator.of(context).push(
                  DefaultPageRoute(
                    builder: (_) => EditPersonalDataView(),
                  ),
                );
              },
            ),
          ),
          SizedBox(width: 18),
          Expanded(
            child: ButtonWidget(
              message: "Déconnexion",
              icon: Icons.logout,
              backgroundColor: Colors.redAccent,
              onPressed: () {
                DialogBuilder.yesOrNo(
                  "Déconnexion",
                  "Voulez-vous vraiment vous déconnecter ?",
                  meController.logout,
                );
              },
            ),
          ),
        ],
      ),

      groundFloor: SingleChildScrollView(
        child: Column(
          children: [
            SizedBox(height: 15),

            Image.asset(width: 100, "images/lock.png"),
            Text(
              textAlign: TextAlign.center,
              style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 30,
              ),
              "Vos données",
            ),

            SizedBox(height: 20),

            Container(
              width: double.infinity,
              padding: EdgeInsets.fromLTRB(20, 10, 20, 10),
              decoration: BoxDecoration(
                borderRadius: const BorderRadius.all(
                  Radius.circular(20),
                ),
                color: backgroundVariantColor,
              ),
              child: Column(
                children: [
                  TextInfoWidget(
                    "Prénom :",
                    User.getCurrentUserInstance().firstName,
                  ),
                  TextInfoWidget(
                    "Nom :",
                    User.getCurrentUserInstance().lastName,
                  ),
                  TextInfoWidget(
                    "Email :",
                    User.getCurrentUserInstance().email,
                  ),
                  TextInfoWidget(
                    "Téléphone :",
                    User.getCurrentUserInstance().tel,
                  ),
                ],
              ),
            ),

            SizedBox(height: 15),

            Image.asset(
              width: 100,
              "images/credit_card.png",
            ),
            Text(
              textAlign: TextAlign.center,
              style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 30,
              ),
              "Vos informations de paiement",
            ),

            SizedBox(height: 20),

            Container(
              width: double.infinity,
              padding: EdgeInsets.fromLTRB(20, 10, 20, 10),
              decoration: BoxDecoration(
                borderRadius: const BorderRadius.all(
                  Radius.circular(20),
                ),
                color: backgroundVariantColor,
              ),
              child: Column(
                children: [
                  TextInfoWidget(
                    "Paypal :",
                    User.getCurrentUserInstance()
                        .emailPaypal,
                  ),
                  TextInfoWidget(
                    "Wero :",
                    User.getCurrentUserInstance().telWero,
                  ),
                  TextInfoWidget(
                    "Rib :",
                    User.getCurrentUserInstance().rib,
                  ),
                ],
              ),
            ),

            SizedBox(height: 130),
          ],
        ),
      ),
    );
  }
}

class TextInfoWidget extends StatelessWidget {
  final String labelText;
  final String valueText;

  const TextInfoWidget(this.labelText, this.valueText, {super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.fromLTRB(0, 5, 0, 5),
      child: Row(
        children: [
          Text(
            style: TextStyle(fontSize: 17, fontWeight: FontWeight.bold),
            labelText,
          ),
          SizedBox(width: 5),
          valueText == ""
              ? Text(
                style: TextStyle(fontStyle: FontStyle.italic, fontSize: 17),
                overflow: TextOverflow.ellipsis,
                maxLines: 1,
                "Aucune information",
              )
              : Text(
                style: TextStyle(fontSize: 17),
                overflow: TextOverflow.ellipsis,
                maxLines: 1,
                valueText,
              ),
        ],
      ),
    );
  }
}
