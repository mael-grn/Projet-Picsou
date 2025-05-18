import 'package:flutter/material.dart';
import 'package:projet_picsou/core/theme/app_theme.dart';
import 'package:projet_picsou/widgets/ui/button_widget.dart';
import 'package:projet_picsou/dialogs/alert_dialog_builder.dart';
import 'package:provider/provider.dart';
import '../controllers/me_controller.dart';
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
      controller.initUser();
      controller.animationsController.forward();
    });
  }

  @override
  Widget build(BuildContext context) {
    super.build(context);
    final meController = context.watch<MeController>();

    if (meController.user == null) {
      return Center(child: CircularProgressIndicator());
    }

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
                                        meController.user!.firstName,
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
                                        meController.user!.lastName,
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
                                        meController.user!.email,
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
                                        meController.user?.tel ??
                                            "Pas de numéro de téléphone",
                                      ),
                                    ],
                                  ),

                                  SizedBox(height: 5),

                                  ButtonWidget(
                                      message: "Modifier",
                                      icon: Icons.edit,
                                      onPressed: () =>
                                      {
                                      Navigator.push(
                                      context,
                                      MaterialPageRoute(builder: (context) => EditPersonalDataView()),
                                      )
                                  }
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
                                          meController.user?.emailPaypal ??
                                              "Pas de compte Paypal",
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
                                          meController.user?.telWero ??
                                              "Pas de compte Wero",
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
                                          meController.user?.rib ??
                                              "Pas de Rib",
                                        ),
                                      ],
                                    ),

                                    SizedBox(height: 5),

                                    ButtonWidget(

                                        message: "Modifier",
                                        icon: Icons.edit,
                                        onPressed: () =>
                                        {
                                          DialogBuilder.warning(
                                            context,
                                            "Pas trop vite !",
                                            "Cette fonctionnalité n'est pas encore disponible, veuillez patenter encore quelques instants, Merci !",
                                          )
                                        }
                                    ),
                                  ],
                                )
                            ),


                            SizedBox(height: 35),

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