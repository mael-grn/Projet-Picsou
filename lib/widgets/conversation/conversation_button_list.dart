import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import '../../controllers/user_controller.dart';
import '../../models/Friend.dart';
import 'conversation_button.dart';

class ConversationButtonList extends StatelessWidget {

  final FriendsController friendsController = FriendsController();

  ConversationButtonList({super.key});

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<List<Friend>>(
      future: friendsController.getAllFriends(),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return SizedBox(
            width: double.infinity,
            child: Center(
              child: CircularProgressIndicator(
                strokeWidth: 4, // Pour ajuster l'épaisseur du cercle
              ),
            ),
          );
        } else if (snapshot.hasData) {
          List<Friend> friends = snapshot.data!;
          return ListView(
            padding: EdgeInsets.zero,
            children: friends.map((friend) {
              return ConversationButton(
                friend,
              );
            }).toList(),
          );
        } else {
          return Text('Erreur de chargement');
        }
      },
    );
  }
}