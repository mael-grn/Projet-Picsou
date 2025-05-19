import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:projet_picsou/utils/token_utils.dart';
import 'package:restart_app/restart_app.dart';
import '../models/user.dart';

class MeController with ChangeNotifier {
  late AnimationController animationsController;
  late Animation<Offset> firstOffsetAnimation;
  late Animation<Offset> secondOffsetAnimation;

  MeController();

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

  Future<void> logout() async {
    HapticFeedback.mediumImpact();
    await TokenUtils.removeToken();
    User.removeCurrentUserInstance();
    Restart.restartApp();
  }

}
