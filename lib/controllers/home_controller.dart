import 'package:flutter/material.dart';
import 'package:projet_picsou/services/user_service.dart';

import '../exceptions/not_logged_in_exception.dart';
import '../models/user.dart';

class HomeController with ChangeNotifier {
  User? currentUser;
  bool showPopup = false;
  String? popupTitle;
  String? popupContent;
  String? popupImage;
  double userBalance = 0.0;
  bool isLoading = false;
  UserService userService;
  late AnimationController animationsController;
  late Animation<Offset> firstOffsetAnimation;
  late Animation<Offset> secondOffsetAnimation;

  HomeController(this.userService);

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

  Future<void> getUserBalance() async {
    try {
      isLoading = true;
      notifyListeners();
      userBalance = await userService.getUserBalance(User.getCurrentUserInstance().id);
    } catch (e) {
      showPopup = true;
      popupTitle = "Une erreur est survenue";
      popupContent = e.toString();
      popupImage = "images/error.png";
    } finally {
      isLoading = false;
      notifyListeners();
    }
  }

  void getCurrentUser() {
    try {
      currentUser = User.getCurrentUserInstance();
    } on NotLoggedInException catch (e) {
      showPopup = true;
      popupTitle = "Une erreur est survenue";
      popupContent = e.message;
      popupImage = "images/error.png";
      notifyListeners();
    }
  }

  void closePopup() {
    showPopup = false;
    popupTitle = null;
    popupContent = null;
    popupImage = null;
    notifyListeners();
  }

}
