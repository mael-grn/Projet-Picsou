import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:projet_picsou/services/friend_service.dart';
import 'package:projet_picsou/services/user_service.dart';
import 'package:projet_picsou/utils/token_utils.dart';
import 'package:restart_app/restart_app.dart';
import '../models/user.dart';

class FriendsController with ChangeNotifier {
  final FriendService friendService;
  User? user;
  List<User> friends = [];
  bool showPopup = false;
  String? popupTitle;
  String? popupContent;
  bool isLoading = false;
  String? error;
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
    isLoading = true;
    notifyListeners();
    friends = await friendService.getFriends();

    isLoading = false;
    notifyListeners();
  }

  void initUser() {
    user = User.getCurrentUserInstance();
  }

}
