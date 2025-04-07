import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import '../../controllers/user_controller.dart';
import '../../core/theme/app_theme.dart';
import '../../models/friend.dart';
import 'conversation_button_widget.dart';

import 'conversation_button_loading_widget.dart';

/// Widget to display a list of conversations, using the ConversationButtonWidget.
class ConversationButtonListWidget extends StatelessWidget {

  final Function(Friend) onConversationButtonPressed;
  final UserController friendsController = UserController();

  ConversationButtonListWidget({super.key,required this.onConversationButtonPressed});

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<List<Friend>>(
      future: friendsController.getAllFriends(),
      builder: (context, snapshot) {

        if (snapshot.connectionState == ConnectionState.waiting) {

          return Expanded(
              child: Container(
                padding: EdgeInsets.fromLTRB(10, 20, 10, 20),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(40),
                    topRight: Radius.circular(40),
                  ),
                  color: darkColor,
                ),
                child: ListView(
                  padding: EdgeInsets.zero,
                  children: [
                    ConversationButtonLoadingWidget(),
                    ConversationButtonLoadingWidget(),
                    ConversationButtonLoadingWidget(),
                    ConversationButtonLoadingWidget(),
                    ConversationButtonLoadingWidget(),
                  ],
                ),
              )
          );

        } else if (snapshot.hasData) {

          List<Friend> friends = snapshot.data!;
          return Expanded(
              child: Container(
                clipBehavior: Clip.hardEdge,
                padding: EdgeInsets.fromLTRB(10, 0, 10, 0),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(40),
                    topRight: Radius.circular(40),
                  ),
                  color: darkColor,
                ),
                child: ListView(
                  padding: EdgeInsets.fromLTRB(0, 20, 0, 115),
                  children: friends.map((friend) {
                    return ConversationButtonWidget(
                      friend,
                      onPressed: () {
                        // Lorsque le bouton est pressé, appel de la fonction pour afficher ConversationGlance
                        onConversationButtonPressed(friend);
                      },
                    );
                  }).toList(),
                ),
              )
          );


        } else {
          return Text('Erreur de chargement');
        }
      },
    );
  }
}