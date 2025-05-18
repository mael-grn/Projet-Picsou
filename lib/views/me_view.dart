import 'package:flutter/material.dart';
import 'package:projet_picsou/core/theme/app_theme.dart';
import 'package:projet_picsou/widgets/ui/button_widget.dart';
import 'package:projet_picsou/dialogs/alert_dialog_builder.dart';
import 'package:provider/provider.dart';
import '../controllers/me_controller.dart';

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
      controller.initUser();
      controller.animationsController.forward();
    });
  }

  @override
  Widget build(BuildContext context) {
    super.build(context);
    final meController = context.watch<MeController>();

    if (meController.showPopup) {
      meController.showPopup = false;
      DialogBuilder.warning(context, meController.popupTitle ?? "",
          meController.popupContent ?? "");
    }

    return Stack(
      children: [
        Container(
          width: double.infinity,
          height: double.infinity,
          padding: EdgeInsets.only(top: 100),
          decoration: BoxDecoration(color: primaryColor),
          child: Column(
            children: [
              Text(
                textAlign: TextAlign.center,
                style: TextStyle(fontSize: 40, fontWeight: FontWeight.bold),
                "${meController.user?.firstName} ${meController.user
                    ?.lastName}",
                overflow: TextOverflow.ellipsis, // Ajout de l'overflow
                maxLines: 1, // Limite à une seule ligne
              ),
              SizedBox(height: 30),
              Expanded(
                child: SlideTransition(
                  position: meController.offsetAnimation,
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

                            Text(
                                textAlign: TextAlign.center,
                                style: TextStyle(
                                    fontSize: 25, fontWeight: FontWeight.bold),
                                "Vos données"
                            ),

                            SizedBox(height: 5),

                            Container(
                                padding: EdgeInsets.fromLTRB(20, 5, 20, 5),
                                width: double.infinity,
                                decoration: BoxDecoration(
                                  borderRadius: const BorderRadius.only(
                                    topLeft: Radius.circular(25),
                                    topRight: Radius.circular(25),
                                    bottomLeft: Radius.circular(5),
                                    bottomRight: Radius.circular(5),
                                  ),
                                  color: backgroundVariantColor,
                                ),
                                child: Row(
                                    mainAxisAlignment: MainAxisAlignment
                                        .spaceBetween,
                                    children: [
                                      Expanded( // Important pour que Text puisse utiliser l'espace disponible
                                        child: Text(
                                            textAlign: TextAlign.start,
                                            style: TextStyle(fontSize: 20,
                                                fontWeight: FontWeight.bold),
                                            "Prénom : ${meController.user
                                                ?.firstName}",
                                            overflow: TextOverflow.ellipsis,
                                            maxLines: 1
                                        ),
                                      ),
                                      IconButton(
                                          color: foregroundColor,
                                          iconSize: 20,
                                          onPressed: () =>
                                              DialogBuilder.warning(
                                                  context, "En travaux",
                                                  "La fonctionnalité n'est pas encore disponible"),
                                          icon: Icon(Icons.edit)
                                      )
                                    ]
                                )
                            ),

                            SizedBox(height: 5),

                            Container(
                                padding: EdgeInsets.fromLTRB(20, 5, 20, 5),
                                width: double.infinity,
                                decoration: BoxDecoration(
                                  borderRadius: const BorderRadius.all(
                                      Radius.circular(5)),
                                  color: backgroundVariantColor,
                                ),
                                child: Row(
                                    mainAxisAlignment: MainAxisAlignment
                                        .spaceBetween,
                                    children: [
                                      Expanded(
                                        child: Text(
                                            textAlign: TextAlign.start,
                                            style: TextStyle(fontSize: 20,
                                                fontWeight: FontWeight.bold),
                                            "Nom : ${meController.user
                                                ?.lastName}",
                                            overflow: TextOverflow.ellipsis,
                                            maxLines: 1
                                        ),
                                      ),
                                      IconButton(
                                          color: foregroundColor,
                                          iconSize: 20,
                                          onPressed: () =>
                                              DialogBuilder.warning(
                                                  context, "En travaux",
                                                  "La fonctionnalité n'est pas encore disponible"),
                                          icon: Icon(Icons.edit)
                                      )
                                    ]
                                )
                            ),

                            SizedBox(height: 5),

                            Container(
                                padding: EdgeInsets.fromLTRB(20, 5, 20, 5),
                                width: double.infinity,
                                height: 60,
                                decoration: BoxDecoration(
                                  borderRadius: const BorderRadius.all(
                                      Radius.circular(5)),
                                  color: backgroundVariantColor,
                                ),
                                child: Row(
                                    mainAxisAlignment: MainAxisAlignment
                                        .spaceBetween,
                                    children: [
                                      Expanded(
                                        child: Text(
                                            textAlign: TextAlign.start,
                                            style: TextStyle(fontSize: 20,
                                                fontWeight: FontWeight.bold),
                                            "Email : ${meController.user
                                                ?.email}",
                                            overflow: TextOverflow.ellipsis,
                                            maxLines: 1
                                        ),
                                      ),
                                      IconButton(
                                          color: foregroundColor,
                                          iconSize: 20,
                                          onPressed: () =>
                                              DialogBuilder.warning(
                                                  context, "En travaux",
                                                  "La fonctionnalité n'est pas encore disponible"),
                                          icon: Icon(Icons.edit)
                                      )
                                    ]
                                )
                            ),

                            SizedBox(height: 5),

                            Container(
                                padding: EdgeInsets.fromLTRB(20, 5, 20, 5),
                                width: double.infinity,
                                height: 60,
                                decoration: BoxDecoration(
                                  borderRadius: const BorderRadius.only(
                                    topLeft: Radius.circular(5),
                                    topRight: Radius.circular(5),
                                    bottomLeft: Radius.circular(25),
                                    bottomRight: Radius.circular(25),
                                  ),
                                  color: backgroundVariantColor,
                                ),
                                child: Row(
                                    mainAxisAlignment: MainAxisAlignment
                                        .spaceBetween,
                                    children: [
                                      Expanded(
                                        child: Text(
                                            textAlign: TextAlign.start,
                                            style: TextStyle(fontSize: 20,
                                                fontWeight: FontWeight.bold),
                                            "Téléphone : ${meController.user
                                                ?.tel}",
                                            overflow: TextOverflow.ellipsis,
                                            maxLines: 1
                                        ),
                                      ),
                                      IconButton(
                                          color: foregroundColor,
                                          iconSize: 20,
                                          onPressed: () =>
                                              DialogBuilder.warning(
                                                  context, "En travaux",
                                                  "La fonctionnalité n'est pas encore disponible"),
                                          icon: Icon(Icons.edit)
                                      )
                                    ]
                                )
                            ),

                            SizedBox(height: 20),

                            Text(
                                textAlign: TextAlign.center,
                                style: TextStyle(
                                    fontSize: 25, fontWeight: FontWeight.bold),
                                "Vos informations de paiement"
                            ),

                            SizedBox(height: 5),

                            Container(
                                padding: EdgeInsets.fromLTRB(20, 5, 20, 5),
                                width: double.infinity,
                                decoration: BoxDecoration(
                                  borderRadius: const BorderRadius.only(
                                    topLeft: Radius.circular(25),
                                    topRight: Radius.circular(25),
                                    bottomLeft: Radius.circular(5),
                                    bottomRight: Radius.circular(5),
                                  ),
                                  color: backgroundVariantColor,
                                ),
                                child: Row(
                                    mainAxisAlignment: MainAxisAlignment
                                        .spaceBetween,
                                    children: [
                                      Expanded( // Important pour que Text puisse utiliser l'espace disponible
                                        child: Text(
                                            textAlign: TextAlign.start,
                                            style: TextStyle(fontSize: 20,
                                                fontWeight: FontWeight.bold),
                                            "Paypal : ${meController.user
                                                ?.emailPaypal}",
                                            overflow: TextOverflow.ellipsis,
                                            maxLines: 1
                                        ),
                                      ),
                                      IconButton(
                                          color: foregroundColor,
                                          iconSize: 20,
                                          onPressed: () =>
                                              DialogBuilder.warning(
                                                  context, "En travaux",
                                                  "La fonctionnalité n'est pas encore disponible"),
                                          icon: Icon(Icons.edit)
                                      )
                                    ]
                                )
                            ),

                            SizedBox(height: 5),

                            Container(
                                padding: EdgeInsets.fromLTRB(20, 5, 20, 5),
                                width: double.infinity,
                                decoration: BoxDecoration(
                                  borderRadius: const BorderRadius.all(
                                      Radius.circular(5)),
                                  color: backgroundVariantColor,
                                ),
                                child: Row(
                                    mainAxisAlignment: MainAxisAlignment
                                        .spaceBetween,
                                    children: [
                                      Expanded(
                                        child: Text(
                                            textAlign: TextAlign.start,
                                            style: TextStyle(fontSize: 20,
                                                fontWeight: FontWeight.bold),
                                            "Wero : ${meController.user
                                                ?.telWero}",
                                            overflow: TextOverflow.ellipsis,
                                            maxLines: 1
                                        ),
                                      ),
                                      IconButton(
                                          color: foregroundColor,
                                          iconSize: 20,
                                          onPressed: () =>
                                              DialogBuilder.warning(
                                                  context, "En travaux",
                                                  "La fonctionnalité n'est pas encore disponible"),
                                          icon: Icon(Icons.edit)
                                      )
                                    ]
                                )
                            ),

                            SizedBox(height: 5),

                            Container(
                                padding: EdgeInsets.fromLTRB(20, 5, 20, 5),
                                width: double.infinity,
                                height: 60,
                                decoration: BoxDecoration(
                                  borderRadius: const BorderRadius.only(
                                    topLeft: Radius.circular(5),
                                    topRight: Radius.circular(5),
                                    bottomLeft: Radius.circular(25),
                                    bottomRight: Radius.circular(25),
                                  ),
                                  color: backgroundVariantColor,
                                ),
                                child: Row(
                                    mainAxisAlignment: MainAxisAlignment
                                        .spaceBetween,
                                    children: [
                                      Expanded(
                                        child: Text(
                                            textAlign: TextAlign.start,
                                            style: TextStyle(fontSize: 20,
                                                fontWeight: FontWeight.bold),
                                            "RIB : ${meController.user?.rib}",
                                            overflow: TextOverflow.ellipsis,
                                            maxLines: 1
                                        ),
                                      ),
                                      IconButton(
                                          color: foregroundColor,
                                          iconSize: 20,
                                          onPressed: () =>
                                              DialogBuilder.warning(
                                                  context, "En travaux",
                                                  "La fonctionnalité n'est pas encore disponible"),
                                          icon: Icon(Icons.edit)
                                      )
                                    ]
                                )
                            ),

                            SizedBox(height: 20),

                            ButtonWidget(
                                buttonBackgroundColor: Colors.redAccent,
                                textColor: foregroundColor,
                                message: "Déconnexion",
                                icon: Icons.logout,
                                onPressed: () =>
                                {
                                  DialogBuilder.yesOrNo(
                                      context,
                                      "Déconnexion",
                                      "Voulez-vous vraiment vous déconnecter ?",
                                      meController.logout
                                  )
                                }
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


      ],
    );
  }

  @override
  bool get wantKeepAlive => true;
}