import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:projet_picsou/services/friend_service.dart';
import '../models/user.dart';

class FriendsController with ChangeNotifier {
  final FriendService friendService;
  List<User> friends = [];
  late AnimationController animationsController;
  late Animation<Offset> firstOffsetAnimation;
  late Animation<Offset> secondOffsetAnimation;

  FriendsController(this.friendService);

  void initAnimations(TickerProvider vsync) {
    animationsController = AnimationController(
      duration: const Duration(milliseconds: 600),
      vsync: vsync,
    );

    firstOffsetAnimation = Tween<Offset>(
      begin: const Offset(0.0, 0.8),
      end: Offset.zero,
    ).animate(CurvedAnimation(
      parent: animationsController,
      curve: Curves.decelerate,
    ));

    secondOffsetAnimation = Tween<Offset>(
      begin: const Offset(0.0, 1.0),
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
