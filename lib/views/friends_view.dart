import 'package:flutter/material.dart';
import 'package:projet_picsou/controllers/friends_controller.dart';
import 'package:projet_picsou/views/search_user_with_email_view.dart';
import 'package:projet_picsou/widgets/friends/friend_widget.dart';
import 'package:provider/provider.dart';
import '../core/custom_navigator.dart';
import '../models/user.dart';
import '../widgets/friends/friend_request_widget.dart';
import '../widgets/ui/button_widget.dart';
import '../widgets/ui/main_page_layout_widget.dart';

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

      body: controller.friends.isEmpty && controller.friendRequests.isEmpty ?


      Padding(
        padding: const EdgeInsets.fromLTRB(30, 40, 30, 0),
        child: SingleChildScrollView(
          child: Column(
            children: [
              Image.asset(
                width: 300,
                "images/alone.png",
              ),
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


          :


      SingleChildScrollView(
        child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [

              if (controller.friendRequests
                  .where((friend) =>
              friend.fromUser.id == User
                  .getCurrentUserInstance()
                  .id)
                  .isNotEmpty)
                Column(
                  children: [
                    SizedBox(height: 20),
                    Row(
                      children: [
                        Text(
                          style: TextStyle(
                            fontSize: 25,
                            fontWeight: FontWeight.bold,
                          ),
                          "Demandes envoyées",
                        ),
                      ],
                    ),
                    SizedBox(height: 8),
                    Column(
                      children: controller.friendRequests.map((request) {
                        return Padding(
                          padding: EdgeInsets.symmetric(vertical: 5),
                          child:FriendRequestWidget(
                              key: ValueKey(request.id),
                              user: request.toUser,
                              onDecline: () =>
                                  controller.declineFriendRequest(request)
                          )
                        );
                      }).toList(),
                    ),
                  ],
                ),
              if (controller.friendRequests
                  .where((friend) =>
              friend.toUser.id == User
                  .getCurrentUserInstance()
                  .id)
                  .isNotEmpty)
                Column(
                  children: [
                    SizedBox(height: 20),
                    Row(
                      children: [
                        Text(
                          style: TextStyle(
                            fontSize: 25,
                            fontWeight: FontWeight.bold,
                          ),
                          "Demandes d'amis",
                        ),
                      ],
                    ),
                    SizedBox(height: 8),
                    Column(
                      children: controller.friendRequests.map((request) {
                        return Padding(
                          padding: EdgeInsets.symmetric(vertical: 5),
                          child:FriendRequestWidget(
                            key: ValueKey(request.id),
                            user: request.fromUser,
                            onAccept: () =>
                                controller.acceptFriendRequest(request),
                            onDecline: () =>
                                controller.declineFriendRequest(request),
                          ),
                        );
                      }).toList(),
                    ),
                  ],
                ),

                if (controller.friends.isNotEmpty)
                  Column(
                    children: [
                      SizedBox(height: 20),
                      Row(
                        children: [
                          Text(
                            style: TextStyle(
                              fontSize: 25,
                              fontWeight: FontWeight.bold,
                            ),
                            "Amis",
                          ),
                        ],
                      ),
                      SizedBox(height: 8),
                      Column(
                        children: controller.friends.map((request) {
                          return Padding(
                            padding: EdgeInsets.symmetric(vertical: 5),
                            child:FriendWidget(
                              key: ValueKey(request.id),
                              user: request.user1.id == User.getCurrentUserInstance().id ? request.user2 : request.user1,
                            ),
                          );
                        }).toList(),
                      ),
                    ],
                  )

            ]
        ),
      ),
    );
  }
}
