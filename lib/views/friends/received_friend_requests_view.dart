import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:projet_picsou/controllers/friends/received_friend_request_controller.dart';
import 'package:provider/provider.dart';
import '../../core/custom_navigator.dart';
import '../../core/theme/app_theme.dart';
import '../../widgets/animations/scale_animation_widget.dart';
import '../../widgets/friends/friend_request_list_item_widget.dart';
import '../../widgets/ui/button_widget.dart';
import '../../widgets/ui/popup_page_widget.dart';
import '../user_profile_view.dart';

class ReceivedFriendRequestsView extends StatefulWidget {
  ReceivedFriendRequestsView({super.key});

  @override
  _ReceivedFriendRequestsViewState createState() =>
      _ReceivedFriendRequestsViewState();
}

class _ReceivedFriendRequestsViewState extends State<ReceivedFriendRequestsView> {
  @override
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      final controller = context.read<ReceivedFriendRequestController>();
      controller.initFriends();
    });
  }

  @override
  Widget build(BuildContext context) {
    final controller = context.watch<ReceivedFriendRequestController>();

    return PopupPageWidget(
      title: "Demandes d'amis reçues",
      body: Column(
        children: [

          SizedBox(height: 40),

          controller.friendRequests.isEmpty
              ? Column(
            mainAxisSize: MainAxisSize.max,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Image.asset(
                width: 300,
                "images/future_friends.png",
              ),
              SizedBox(height: 20),
              Text(
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: 16,
                ),
                "Vous n'avez pas encore reçu de demandes d'amis.",
              ),
            ],
          )
              :
          Column(
            children:
            controller.friendRequests.map((request) {
              return Padding(
                padding: EdgeInsets.symmetric(vertical: 5),
                child: FriendRequestWidget(
                  key: ValueKey(request.id),
                  user: request.fromUser,
                  onAccept: () => controller.acceptFriendRequest(request),
                  onDecline: () => controller.declineFriendRequest(request),
                  onTap: () {
                    HapticFeedback.mediumImpact();
                    CustomNavigator.pushFromRight(
                      UserProfileView(
                        user: request.fromUser,
                        showSensitive: false,
                        actions: [
                          ButtonWidget(
                            message: "Supprimer la demande",
                            icon: Icons.delete,
                            backgroundColor: invalidColor,
                            onPressed: () {
                              HapticFeedback.mediumImpact();
                              controller.declineFriendRequest(request);
                              CustomNavigator.back();
                            },
                          ),
                          SizedBox(width: 10),
                          ButtonWidget(
                            message: "Accepter la demande",
                            icon: Icons.check,
                            onPressed: () {
                              HapticFeedback.mediumImpact();
                              controller.acceptFriendRequest(request);
                              CustomNavigator.back();
                            },
                          )

                        ],
                      ),
                      otherContext: context,
                    );
                  },
                ),
              );
            }).toList(),
          ),
        ],
      ),


    );
  }
}
