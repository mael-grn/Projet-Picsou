import 'package:flutter/material.dart';
import 'package:projet_picsou/core/theme/app_theme.dart';
import 'package:projet_picsou/widgets/ui/button_widget.dart';
import '../core/PageRoute.dart';

class TroubleshootingView extends StatelessWidget {
  const TroubleshootingView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SizedBox(
        width: double.infinity,
        height: double.infinity,
        child: Container(
          color: backgroundColor,
          child: Stack(
            children: [
              Padding(
                padding: EdgeInsets.fromLTRB(20, 0, 20, 0),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Expanded(
                      child: SingleChildScrollView(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            SizedBox(height: 100),
                            Text(
                              "Résolution de problèmes",
                              style: TextStyle(
                                fontSize: 45,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            SizedBox(height: 45),
                            Text(
                              "Que faire si l'application ne fonctionne pas dès le démarrage ?",
                              style: TextStyle(
                                fontSize: 20,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            SizedBox(height: 10),
                            Text(
                                "Tout d'abord, ne vous inquiétez pas, cela peut arriver. La première chose à essayer est de redémarrer l'application. Si cela ne fonctionne pas, essayez de redémarrer votre appareil. Si le problème persiste, il est possible que vous deviez réinstaller l'application ou contacter le support technique. Dans tous les cas, ne vous inquietez pas, vos données ne seront pas perdues."
                            ),
                            Divider(
                              thickness: 1,
                              color: Colors.grey,
                              height: 20,
                            ),
                            Text(
                              "L'application ne se connecte pas à Internet",
                              style: TextStyle(
                                fontSize: 20,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            SizedBox(height: 10),
                            Text(
                              "Vérifiez que votre appareil est bien connecté à Internet. Essayez d’ouvrir une page web dans votre navigateur. Si la connexion fonctionne ailleurs, redémarrez l’application ou vérifiez les autorisations réseau.",
                            ),
                            Divider(
                              thickness: 1,
                              color: Colors.grey,
                              height: 20,
                            ),
                            Text(
                              "Je ne reçois pas les notifications",
                              style: TextStyle(
                                fontSize: 20,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            SizedBox(height: 10),
                            Text(
                              "Assurez-vous que les notifications sont activées pour l’application dans les paramètres de votre appareil. Vérifiez aussi que le mode Ne pas déranger n’est pas activé.",
                            ),
                            Divider(
                              thickness: 1,
                              color: Colors.grey,
                              height: 20,
                            ),
                            Text(
                              "L’application plante ou se ferme toute seule",
                              style: TextStyle(
                                fontSize: 20,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            SizedBox(height: 10),
                            Text(
                              "Essayez de fermer complètement l’application puis de la relancer. Si le problème persiste, redémarrez votre appareil ou réinstallez l’application.",
                            ),
                            SizedBox(height: 100),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              Positioned(
                  left: 20,
                  right: 20,
                  bottom: 30,
                  child: ButtonWidget(
                    tag: "troubleshooting",
                    backgroundColor: foregroundVariantColor,
                    message: "Fermer",
                    icon: Icons.close,
                    onPressed: () {
                      PageRouter.back();
                    },
                  ),
              )
            ],
          )
        ),
      ),
    );
  }
}
