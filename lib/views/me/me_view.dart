import 'package:flutter/material.dart';
import 'package:projet_picsou/dialogs/alert_dialog_builder.dart';
import 'package:projet_picsou/services/session_service.dart';
import 'package:projet_picsou/views/me/paiement_data_view.dart';
import 'package:projet_picsou/views/me/personal_data_view.dart';
import 'package:projet_picsou/widgets/ui/modern_tile_widget.dart';
import 'package:provider/provider.dart';
import '../../controllers/me/me_controller.dart';
import '../../core/custom_navigator.dart';
import '../../widgets/ui/main_page_layout_widget.dart';
import '../../core/theme/app_theme.dart'; // Assure-toi d'importer les couleurs

class MeView extends StatefulWidget {
  const MeView({super.key});

  @override
  _MeViewState createState() => _MeViewState();
}

class _MeViewState extends State<MeView> {
  @override
  Widget build(BuildContext context) {
    final meController = context.watch<MeController>();

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
            ModernTileWidget(
              icon: Icons.person,
              title: 'Mes données personnelles',
              onTap: () {
                CustomNavigator.pushFromRight(const PersonalDataView());
              },
            ),
            ModernTileWidget(
              icon: Icons.monetization_on_outlined,
              title: 'Mes données de paiement',
              onTap: () {
                CustomNavigator.pushFromRight(const PaiementDataView());
              },
            ),
            ModernTileWidget(
              icon: Icons.settings,
              title: 'Paramètres',
              onTap: () {
                DialogBuilder.warning(
                  "Désolé...",
                  "Cette fonctionnalité n'est pas encore implémentée. Merci de revenir plus tard.",
                );
              },
            ),
            ModernTileWidget(
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
