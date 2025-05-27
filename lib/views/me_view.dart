import 'package:flutter/material.dart';
import 'package:projet_picsou/dialogs/alert_dialog_builder.dart';
import 'package:projet_picsou/services/session_service.dart';
import 'package:projet_picsou/views/paiement_data_view.dart';
import 'package:projet_picsou/views/personal_data_view.dart';
import 'package:provider/provider.dart';
import '../controllers/me_controller.dart';
import '../core/theme/custom_navigator.dart';
import '../widgets/ui/main_page_layout_widget.dart';
import '../core/theme/app_theme.dart'; // Assure-toi d'importer les couleurs

class MeView extends StatefulWidget {
  const MeView({super.key});

  @override
  _MeViewState createState() => _MeViewState();
}

class _MeViewState extends State<MeView> {
  @override
  Widget build(BuildContext context) {
    final meController = context.watch<MeController>();

    Widget modernTile({
      required IconData icon,
      required String title,
      required VoidCallback onTap,
      Color? iconColor,
    }) {
      return Padding(
        padding: const EdgeInsets.symmetric(horizontal: 0, vertical: 8),
        child: Hero(
            tag: "button-$title",
            child: Material(
              color: backgroundColor,
              borderRadius: BorderRadius.circular(18),
              elevation: 2,
              shadowColor: Colors.black12,
              child: InkWell(
                borderRadius: BorderRadius.circular(18),
                onTap: onTap,
                child: Container(
                  padding: const EdgeInsets.symmetric(vertical: 18, horizontal: 16),
                  child: Row(
                    children: [
                      Icon(icon, color: iconColor ?? foregroundVariantColor, size: 28),
                      const SizedBox(width: 18),
                      Expanded(
                        child: Text(
                          title,
                          style: const TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                      ),
                      const Icon(Icons.chevron_right, color: secondaryColor, size: 26),
                    ],
                  ),
                ),
              ),
            ),
        )
      );
    }

    return MainPageLayoutWidget(
      title: const Text(
        "Mon profil",
        overflow: TextOverflow.ellipsis,
        maxLines: 1,
        textAlign: TextAlign.start,
        style: TextStyle(fontWeight: FontWeight.w600, fontSize: 35),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            const SizedBox(height: 15),
            modernTile(
              icon: Icons.person,
              title: 'Mes données personnelles',
              onTap: () {
                CustomNavigator.push(const PersonalDataView());
              },
            ),
            modernTile(
              icon: Icons.monetization_on_outlined,
              title: 'Mes données de paiement',
              onTap: () {
                CustomNavigator.push(const PaiementDataView());
              },
            ),
            modernTile(
              icon: Icons.settings,
              title: 'Paramètres',
              onTap: () {
                DialogBuilder.warning(
                  "Désolé...",
                  "Cette fonctionnalité n'est pas encore implémentée. Merci de revenir plus tard.",
                );
              },
            ),
            modernTile(
              icon: Icons.logout,
              title: 'Déconnexion',
              iconColor: Colors.redAccent,
              onTap: () {
                DialogBuilder.yesOrNo(
                  "Déconnexion",
                  "Voulez-vous vraiment vous déconnecter ?",
                  SessionService.closeSession,
                );
              },
            ),
            const SizedBox(height: 130),
          ],
        ),
      ),
    );
  }
}
