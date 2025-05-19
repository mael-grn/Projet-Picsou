import 'package:flutter/material.dart';
import 'package:projet_picsou/dialogs/alert_dialog_builder.dart';
import 'package:projet_picsou/services/user_service.dart';
import '../exceptions/request_exception.dart';
import '../models/user.dart';

class HomeController with ChangeNotifier {
  double userBalance = 0.0;
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
    DialogBuilder.loading();
    try {
      userBalance = await userService.getUserBalance(User.getCurrentUserInstance().id);
      DialogBuilder.closeCurrentDialog();
      notifyListeners();
    } on NetworkException catch (e) {
      DialogBuilder.networkError(e.networkError);
    } catch (e) {
      DialogBuilder.appError();
    }
  }

}
