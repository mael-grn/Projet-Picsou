import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:projet_picsou/controllers/group_controller.dart';
import 'package:projet_picsou/models/group.dart';
import '../../controllers/user_controller.dart';
import '../../core/theme/app_theme.dart';
import '../../models/friend.dart';
import 'conversation_button_widget.dart';

import 'conversation_button_loading_widget.dart';

/// Widget to display a list of conversations, using the ConversationButtonWidget.
class ConversationButtonListWidget extends StatelessWidget {

  final Function(Group) onConversationButtonPressed;
  final GroupController groupController = GroupController();

  ConversationButtonListWidget({super.key,required this.onConversationButtonPressed});

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<List<Group>>(
      future: groupController.getAllGroups(),
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

          List<Group> groups = snapshot.data!;
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
                  children: groups.map((group) {
                    return ConversationButtonWidget(
                      nom: "Test",
                      sousTitre: "WOW",
                      group: group,
                      onPressed: () {
                        // Lorsque le bouton est pressé, appel de la fonction pour afficher ConversationGlance
                        onConversationButtonPressed(group);
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