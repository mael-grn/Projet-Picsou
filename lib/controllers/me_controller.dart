import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:projet_picsou/services/user_service.dart';
import 'package:projet_picsou/utils/token_utils.dart';
import 'package:restart_app/restart_app.dart';
import '../models/user.dart';

class MeController with ChangeNotifier {
  final UserService userService;
  User? user;
  bool showPopup = false;
  String? popupTitle;
  String? popupContent;
  bool isLoading = false;
  String? error;
  late AnimationController animationsController;
  late Animation<Offset> offsetAnimation;

  MeController(this.userService);

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

  void initUser() {
    try {
      user = User.getCurrentUserInstance();
    } catch (e) {
      user = null;
      logout();
    } finally {
      notifyListeners();
    }
  }

  void closePopup() {
    showPopup = false;
    popupContent = null;
    notifyListeners();
  }

  Future<void> logout() async {
    HapticFeedback.mediumImpact();
    await TokenUtils.removeToken();
    User.removeCurrentUserInstance();
    Restart.restartApp();
  }

}
