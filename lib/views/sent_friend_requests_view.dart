import 'package:flutter/material.dart';
import 'package:projet_picsou/controllers/received_friend_request_controller.dart';
import 'package:provider/provider.dart';
import '../controllers/sent_friend_request_controller.dart';
import '../widgets/animations/scale_animation_widget.dart';
import '../widgets/friends/friend_request_widget.dart';
import '../widgets/ui/popup_page_widget.dart';

class SentFriendRequestsView extends StatefulWidget {
  SentFriendRequestsView({super.key});

  @override
  _SentFriendRequestsViewState createState() =>
      _SentFriendRequestsViewState();
}

class _SentFriendRequestsViewState extends State<SentFriendRequestsView> {
  @override
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      final controller = context.read<SentFriendRequestController>();
      controller.initFriends();
    });
  }

  @override
  Widget build(BuildContext context) {
    final controller = context.watch<SentFriendRequestController>();

    return PopupPageWidget(
      title: "Demandes d'amis envoyées",
      body: Column(
        children: [

          SizedBox(height: 40),

          controller.friendRequests.isEmpty
              ? Column(
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
                "Vous n'avez pas encore envoyé de demandes d'amis.",
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
                  user: request.toUser,
                  onDecline: () => controller.declineFriendRequest(request),
                ),
              );
            }).toList(),
          ),
        ],
      ),


    );
  }
}
