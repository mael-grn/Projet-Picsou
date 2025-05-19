import 'package:flutter/material.dart';
import 'package:projet_picsou/core/theme/app_theme.dart';
import 'package:projet_picsou/models/user.dart';
import 'package:projet_picsou/dialogs/alert_dialog_builder.dart';
import 'package:provider/provider.dart';
import '../controllers/me_controller.dart';
import '../core/PageRoute.dart';
import 'edit_personal_data_view.dart';

class MeView extends StatefulWidget {
  const MeView({super.key});

  @override
  _MeViewState createState() => _MeViewState();
}

class _MeViewState extends State<MeView>
    with TickerProviderStateMixin, AutomaticKeepAliveClientMixin {

  @override
  void initState() {
    super.initState();
    final controller = Provider.of<MeController>(context, listen: false);
    controller.initAnimations(this);
    WidgetsBinding.instance.addPostFrameCallback((_) {
      controller.animationsController.forward();
    });
  }

  @override
  Widget build(BuildContext context) {
    super.build(context);
    final meController = context.watch<MeController>();

    return Container(
        color: primaryColor,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Row(
              children: [
                Padding(
                  padding: EdgeInsets.fromLTRB(15, 75, 15, 20),
                  child: Text(
                    "${User.getCurrentUserInstance().firstName} ${User.getCurrentUserInstance().lastName}",
                    overflow: TextOverflow.ellipsis, // Ajout de l'overflow
                    maxLines: 1,
                    textAlign: TextAlign.start,
                    style: TextStyle(
                      fontWeight: FontWeight.w600,
                      fontSize: 35,
                    ),
                  ),
                ),
              ],
            ),
            Expanded(
              child: SlideTransition(
                position: meController.firstOffsetAnimation,
                child: Container(
                  decoration: BoxDecoration(
                    borderRadius: const BorderRadius.only(
                      topLeft: Radius.circular(40),
                      topRight: Radius.circular(40),
                    ),
                    color: backgroundVariantColor,
                  ),
                  child: Column(
                    children: [
                      Padding(
                        padding: EdgeInsets.fromLTRB(15, 20, 15, 20),
                        child: Row(
                          children: [
                            Expanded(
                              child: OutlinedButton.icon(
                                style: OutlinedButton.styleFrom(
                                  foregroundColor: foregroundColor,
                                  side: BorderSide(color: foregroundColor, width: 1.5),
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(30),
                                  ),
                                  padding: EdgeInsets.symmetric(horizontal: 18, vertical: 10),
                                ),
                                icon: Icon(Icons.edit, size: 20),
                                label: Text("Modifier", style: TextStyle(fontWeight: FontWeight.w500)),
                                onPressed: () {
                                  Navigator.of(context).push(DefaultPageRoute(builder: (_) => EditPersonalDataView()));
                                },
                              ),
                            ),
                            SizedBox(width: 15),
                            Expanded(
                              child: OutlinedButton.icon(
                                style: OutlinedButton.styleFrom(
                                  foregroundColor: Colors.redAccent,
                                  side: BorderSide(color: Colors.redAccent, width: 1.5),
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(30),
                                  ),
                                  padding: EdgeInsets.symmetric(horizontal: 18, vertical: 10),
                                ),
                                icon: Icon(Icons.logout, size: 20),
                                label: Text("Déconnexion", style: TextStyle(fontWeight: FontWeight.w500)),
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
                      ),
                      Expanded(
                        child: SlideTransition(
                          position: meController.secondOffsetAnimation,
                          child: Container(
                              width: double.infinity,
                              padding: EdgeInsets.all(20),
                              decoration: BoxDecoration(
                                borderRadius: const BorderRadius.only(
                                  topLeft: Radius.circular(40),
                                  topRight: Radius.circular(40),
                                ),
                                color: backgroundColor,
                              ),
                              child: SingleChildScrollView(
                                child: Column(
                                  children: [

                                    SizedBox(height: 15),

                                    Row(
                                        children: [Text(
                                            style: TextStyle(
                                                fontWeight: FontWeight.bold,
                                                fontSize: 20),
                                            "Vos données"
                                        )
                                        ]
                                    ),

                                    SizedBox(height: 5),

                                    Container(
                                      width: double.infinity,
                                      padding: EdgeInsets.all(10),
                                      decoration: BoxDecoration(
                                        borderRadius: const BorderRadius.all(
                                            Radius.circular(20)),
                                        color: backgroundVariantColor,
                                      ),
                                      child: Column(
                                        children: [
                                          Row(
                                            children: [
                                              Text(style: TextStyle(
                                                  fontWeight: FontWeight.bold),
                                                  "Prénom : "),
                                              Text(
                                                overflow: TextOverflow.ellipsis,
                                                maxLines: 1,
                                                User.getCurrentUserInstance().firstName,
                                              ),
                                            ],
                                          ),

                                          SizedBox(height: 5),

                                          Row(
                                            children: [
                                              Text(style: TextStyle(
                                                  fontWeight: FontWeight.bold),
                                                  "Nom : "),
                                              Text(
                                                overflow: TextOverflow.ellipsis,
                                                maxLines: 1,
                                                User.getCurrentUserInstance().lastName,
                                              ),
                                            ],
                                          ),

                                          SizedBox(height: 5),

                                          Row(
                                            children: [
                                              Text(style: TextStyle(
                                                  fontWeight: FontWeight.bold),
                                                  "Email : "),
                                              Text(
                                                overflow: TextOverflow.ellipsis,
                                                maxLines: 1,
                                                User.getCurrentUserInstance().email,
                                              ),
                                            ],
                                          ),

                                          SizedBox(height: 5),

                                          Row(
                                            children: [
                                              Text(style: TextStyle(
                                                  fontWeight: FontWeight.bold),
                                                  "Téléphone : "),
                                              Text(
                                                  overflow: TextOverflow.ellipsis,
                                                  maxLines: 1,
                                                  User.getCurrentUserInstance().tel
                                              ),
                                            ],
                                          ),
                                        ],
                                      ),
                                    ),

                                    SizedBox(height: 15),

                                    Row(
                                        children: [Text(
                                            style: TextStyle(
                                                fontWeight: FontWeight.bold,
                                                fontSize: 20),
                                            "Vos informations de paiement"
                                        )
                                        ]
                                    ),

                                    SizedBox(height: 5),

                                    Container(
                                        width: double.infinity,
                                        padding: EdgeInsets.all(10),
                                        decoration: BoxDecoration(
                                          borderRadius: const BorderRadius.all(
                                              Radius.circular(20)),
                                          color: backgroundVariantColor,
                                        ),
                                        child: Column(
                                          children: [
                                            Row(
                                              children: [
                                                Text(style: TextStyle(
                                                    fontWeight: FontWeight.bold),
                                                    "Paypal : "),
                                                Text(
                                                    overflow: TextOverflow.ellipsis,
                                                    maxLines: 1,
                                                    User.getCurrentUserInstance().emailPaypal
                                                ),
                                              ],
                                            ),

                                            SizedBox(height: 5),

                                            Row(
                                              children: [
                                                Text(style: TextStyle(
                                                    fontWeight: FontWeight.bold),
                                                    "Wero : "),
                                                Text(
                                                    overflow: TextOverflow.ellipsis,
                                                    maxLines: 1,
                                                    User.getCurrentUserInstance().telWero
                                                ),
                                              ],
                                            ),

                                            SizedBox(height: 5),

                                            Row(
                                              children: [
                                                Text(style: TextStyle(
                                                    fontWeight: FontWeight.bold),
                                                    "Rib : "),
                                                Text(
                                                    overflow: TextOverflow.ellipsis,
                                                    maxLines: 1,
                                                    User.getCurrentUserInstance().rib
                                                ),
                                              ],
                                            ),
                                          ],
                                        )
                                    ),

                                    SizedBox(height: 130),
                                  ],
                                ),
                              )
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ],
        )
    );
  }

  @override
  bool get wantKeepAlive => true;
}