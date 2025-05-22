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
        "Mon profil",
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
            Hero(
              tag: User.getCurrentUserInstance().profilPictureRef,
              child: Image.network(
                User.getCurrentUserInstance().profilPictureRef,
                width: 200,
                height: 200,
              ),
            ),
            SizedBox(height: 15),
            Text(
              textAlign: TextAlign.center,
              style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 40,
              ),
              "${User.getCurrentUserInstance().firstName} ${User.getCurrentUserInstance().lastName}",
            ),

            Divider(
              thickness: 1,
              color: Colors.grey,
              height: 50,
            ),
            Row(
              children: [
                Image.asset(width: 50, "images/lock.png"),
                Text(
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 20,
                  ),
                  "Données personnelles",
                ),
              ],
            ),



            SizedBox(height: 15),

            TextInfoWidget(
              "Email :",
              User.getCurrentUserInstance().email,
            ),
            TextInfoWidget(
              "Téléphone :",
              User.getCurrentUserInstance().tel,
            ),

            Divider(
              thickness: 1, // épaisseur de la barre
              color: Colors.grey, // couleur de la barre
              height: 30, // espace vertical occupé
            ),

            Row(
              children: [
                Image.asset(width: 75, "images/credit_card.png"),
                Text(
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 20,
                  ),
                  "Paiement",
                ),
              ],
            ),


            SizedBox(height: 10),

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
