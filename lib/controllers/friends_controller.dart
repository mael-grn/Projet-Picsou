import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:projet_picsou/services/friend_service.dart';
import '../models/user.dart';

class FriendsController with ChangeNotifier {
  final FriendService friendService;
  List<User> friends = [];
  late AnimationController animationsController;
  late Animation<Offset> offsetAnimation;

  FriendsController(this.friendService);

  void initAnimations(TickerProvider vsync) {
    animationsController = AnimationController(
      duration: const Duration(milliseconds: 600),
      vsync: vsync,
    );

    offsetAnimation = Tween<Offset>(
      begin: const Offset(0.0, 1),
      end: Offset.zero,
    ).animate(CurvedAnimation(
      parent: animationsController,
      curve: Curves.decelerate,
    ));
  }

  Future<void> initFriends() async {
    friends = await friendService.getFriends();
  }

}
