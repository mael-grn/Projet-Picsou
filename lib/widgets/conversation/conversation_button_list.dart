import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import '../../controllers/user_controller.dart';
import '../../core/theme/app_theme.dart';
import '../../models/Friend.dart';
import 'conversation_button.dart';

import 'conversation_button_loading.dart';

class ConversationButtonList extends StatelessWidget {

  final FriendsController friendsController = FriendsController();

  ConversationButtonList({super.key});

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
                    ConversationButtonLoading(),
                    ConversationButtonLoading(),
                    ConversationButtonLoading(),
                    ConversationButtonLoading(),
                    ConversationButtonLoading(),
                  ],
                ),
              )
          );

        } else if (snapshot.hasData) {

          List<Friend> friends = snapshot.data!;
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
                  children: friends.map((friend) {
                    return ConversationButton(
                      friend,
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