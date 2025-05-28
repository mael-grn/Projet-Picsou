import 'package:flutter/material.dart';
import 'package:projet_picsou/controllers/friends_controller.dart';
import 'package:projet_picsou/views/received_friend_requests_view.dart';
import 'package:projet_picsou/views/search_user_with_email_view.dart';
import 'package:projet_picsou/views/sent_friend_requests_view.dart';
import 'package:projet_picsou/widgets/friends/friend_widget.dart';
import 'package:provider/provider.dart';
import '../core/custom_navigator.dart';
import '../models/user.dart';
import '../widgets/ui/button_widget.dart';
import '../widgets/ui/main_page_layout_widget.dart';
import '../widgets/ui/modern_tile_widget.dart';

class FriendsView extends StatefulWidget {
  const FriendsView({super.key});

  @override
  _FriendsViewState createState() => _FriendsViewState();
}

class _FriendsViewState extends State<FriendsView> {
  @override
  void initState() {
    super.initState();
    final controller = Provider.of<FriendsController>(context, listen: false);
    WidgetsBinding.instance.addPostFrameCallback((_) {
      controller.initFriends();
    });
  }

  @override
  Widget build(BuildContext context) {
    final controller = context.watch<FriendsController>();

    return MainPageLayoutWidget(
      title: Text(
        'Mes amis',
        textAlign: TextAlign.start,
        style: TextStyle(fontWeight: FontWeight.w600, fontSize: 35),
      ),

      intermediate: ButtonWidget(
        tag: "search_user",
        message: "Ajouter un ami",
        icon: Icons.add,
        onPressed: () {
          CustomNavigator.pushFromRight(SearchUserWithEmailView());
        },
      ),

      body:
          Column(
            children: [
              const SizedBox(height: 15),
              ModernTileWidget(
                icon: Icons.call_made,
                title: 'Demandes d\'amis envoyées',
                onTap: () {
                  CustomNavigator.pushFromRight(SentFriendRequestsView());
                },
              ),
              ModernTileWidget(
                icon: Icons.call_received,
                title: 'Demandes d\'amis reçues',
                onTap: () {
                  CustomNavigator.pushFromRight(ReceivedFriendRequestsView());
                },
              ),
              controller.friends.isEmpty
                  ? Padding(
                padding: const EdgeInsets.fromLTRB(30, 40, 30, 0),
                child: SingleChildScrollView(
                  child: Column(
                    children: [
                      Image.asset(width: 300, "images/alone.png"),
                      SizedBox(height: 20),
                      Text(
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          fontSize: 30,
                          fontWeight: FontWeight.bold,
                        ),
                        "Vous n'avez pas encore ajouté d'amis !",
                      ),
                      SizedBox(height: 10),
                      Text(
                        style: TextStyle(fontSize: 17),
                        textAlign: TextAlign.center,
                        "Pour commencer, appuyez sur le bouton ci-dessus pour ajouter un ami à partir de son adresse e-mail.",
                      ),
                    ],
                  ),
                ),
              )
                  : Column(
                children:
                controller.friends.map((request) {
                  return Padding(
                    padding: EdgeInsets.symmetric(vertical: 5),
                    child: FriendWidget(
                      key: ValueKey(request.id),
                      friendId: request.id,
                      user:
                      request.user1.id ==
                          User.getCurrentUserInstance().id
                          ? request.user2
                          : request.user1,
                    ),
                  );
                }).toList(),
              ),
              SizedBox(height: 150),
            ],
          )
    );
  }
}
