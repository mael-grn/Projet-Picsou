import 'package:flutter/material.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';
import 'package:projet_picsou/controllers/entry_point_controller.dart';
import 'package:provider/provider.dart';

import '../core/theme/app_theme.dart';
import '../widgets/ui/button_widget.dart';
import '../widgets/ui/popup.dart';

class EntryPointView extends StatefulWidget {
  const EntryPointView({super.key});

  @override
  _EntryPointViewState createState() => _EntryPointViewState();
}

class _EntryPointViewState extends State<EntryPointView> {
  late Future<void> _checkTokenFuture;

  @override
  void initState() {
    super.initState();
    _checkTokenFuture = Provider.of<EntryPointController>(context, listen: false).checkToken();
  }

  // Nouvelle méthode pour relancer la vérification du token
  void _retryCheckToken() {
    setState(() {
      final entryPointController = Provider.of<EntryPointController>(context, listen: false);
      entryPointController.resetState();
      _checkTokenFuture = entryPointController.checkToken();
    });
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'PICSOU',
      debugShowCheckedModeBanner: false,
      theme: appTheme,
      home: Scaffold(
        body: FutureBuilder<void>(
          future: _checkTokenFuture,
          builder: (BuildContext context, AsyncSnapshot<void> snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return SizedBox(
                width: double.infinity,
                height: double.infinity,
                child: Center(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      LoadingAnimationWidget.inkDrop(
                        color: foregroundColor,
                        size: 30,
                      ),
                      const SizedBox(height: 20),
                      Text(
                        textAlign: TextAlign.center,
                        "Connexion au serveur...",
                        style: TextStyle(color: foregroundColor),
                      ),
                    ],
                  ),
                ),
              );
            } else if (snapshot.hasError) {
              final entryPointController = Provider.of<EntryPointController>(context);
              return SizedBox(
                width: double.infinity,
                height: double.infinity,
                child: Stack(
                  children: [
                    PopupWidget(
                      show: entryPointController.showPopup,
                      title: entryPointController.popupTitle ?? "Erreur",
                      content: entryPointController.popupContent ?? "Une erreur inattendue s'est produite.",
                      imageSrc: entryPointController.popupImage,
                      showCloseButton: false,
                      buttons: [
                        ButtonWidget(
                          message: "Réessayer",
                          icon: Icons.refresh,
                          backgroundColor: foregroundVariantColor,
                          textColor: backgroundColor,
                          onPressed: _retryCheckToken, // Appeler la nouvelle méthode
                        ),
                      ],
                    ),
                  ],
                ),
              );
            } else {
              final entryPointController = Provider.of<EntryPointController>(context);
              return entryPointController.page ?? const SizedBox.shrink();
            }
          },
        ),
      ),
    );
  }
}