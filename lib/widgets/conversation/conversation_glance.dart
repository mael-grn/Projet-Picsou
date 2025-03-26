
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:projet_picsou/core/theme/app_theme.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';

import '../../controllers/user_controller.dart';

class ConversationGlance extends StatelessWidget {

  final int frienId;
  final UserController userController = UserController();
  final Function closeFunction;

  ConversationGlance({required this.frienId, required this.closeFunction, super.key});

  @override
  Widget build(BuildContext context) {

    return FutureBuilder(
        future: userController.getFriend(frienId),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(40),
                  topRight: Radius.circular(40),
                ),
                color: darkColor,
              ),
              child: Center(
                child: LoadingAnimationWidget.inkDrop(
                  color: primaryLightColor,
                  size: 30,
                ),
              ),
            );
          } else if (snapshot.hasData) {
            return Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(40),
                  topRight: Radius.circular(40),
                ),
                color: darkColor,
              ),
              child: ElevatedButton(onPressed:() {closeFunction();}, child: Text('Fermer')),
            );
          } else {
            return Text('Erreur de chargement');
          }
        }
    );
  }
}