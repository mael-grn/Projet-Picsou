import 'package:flutter/material.dart';
import 'package:projet_picsou/dialogs/alert_dialog_builder.dart';
import 'package:projet_picsou/services/user_service.dart';
import '../exceptions/request_exception.dart';

class HomeController with ChangeNotifier {
  double userBalance = 0.0;
  UserService userService;

  HomeController(this.userService);

  Future<void> getUserBalance() async {
    DialogBuilder.loading();
    try {
      DialogBuilder.closeCurrentDialog();
      notifyListeners();
    } on NetworkException catch (e) {
      DialogBuilder.networkError(e.networkError);
    } catch (e) {
      DialogBuilder.appError();
    }
  }

}
