import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:projet_picsou/controllers/friends/friends_controller.dart';
import 'package:projet_picsou/views/friends/received_friend_requests_view.dart';
import 'package:projet_picsou/views/friends/search_user_with_email_view.dart';
import 'package:projet_picsou/views/friends/sent_friend_requests_view.dart';
import 'package:projet_picsou/widgets/list_item_profile_elem_widget.dart';
import 'package:provider/provider.dart';
import '../../core/custom_navigator.dart';
import '../../core/theme/app_theme.dart';
import '../../models/user.dart';
import '../../widgets/ui/button_widget.dart';
import '../../widgets/ui/main_page_layout_widget.dart';
import '../../widgets/ui/modern_tile_widget.dart';
import '../user_profile_view.dart';

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
                    child: ListItemProfileElemWidget(
                      id: request.id,
                      name:
                      request.user1.id ==
                          User.getCurrentUserInstance().id
                          ? "${request.user2.firstName} ${request.user2.lastName}"
                          : "${request.user1.firstName} ${request.user1.lastName}",
                      imageUrl: request.user1.id ==
                          User.getCurrentUserInstance().id
                          ? request.user2.profilPictureRef
                          : request.user1.profilPictureRef,
                      onTap: () {
                        HapticFeedback.mediumImpact();
                        CustomNavigator.pushFromRight(
                          UserProfileView(
                            user: request.user1.id ==
                                User.getCurrentUserInstance().id
                                ? request.user2
                                : request.user1,
                            showSensitive: true,
                            actions: [
                              ButtonWidget(
                                message: "Supprimer l'amis",
                                icon: Icons.delete,
                                backgroundColor: invalidColor,
                                onPressed: () {
                                  HapticFeedback.mediumImpact();
                                  controller.deleteFriend(request.user1.id ==
                                      User.getCurrentUserInstance().id
                                      ? request.user2.id
                                      : request.user1.id);
                                },
                              ),
                            ],
                          ),
                          otherContext: context,
                        );
                      }
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
