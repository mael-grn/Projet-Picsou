import 'package:flutter/material.dart';
import '../exceptions/request_exception.dart';
import '../models/user.dart';
import '../services/auth_service.dart';
import '../views/splash_screen_view.dart';
import '../widgets/global_layout.dart';

class EntryPointController with ChangeNotifier {
  String? error;
  Widget? page;
  bool isLoading = false;
  AuthService authService;

  EntryPointController(this.authService);

  Future<void> checkToken() async {
    isLoading = true;
    notifyListeners();
    try {
      User user = await authService.verifyToken();
      User.setCurrentUserInstance(user);
      page = GlobalLayout();
    } on RequestException catch (e) {
      User.removeCurrentUserInstance();
      if (e.networkErrorCode == 404 || e.networkErrorCode == 401) {
        page = SplashScreenView();
      } else {
        error = "Une erreur serveur est survenue. Merci de vérifier si l'application est à jour. Nous faisons tout notre possible pour résoudre le problème.";
      }
    } catch (e) {
      error = "Une erreur est survenue dans l'application. Verifiez les mises a jour et réessayez. ($e)";
    } finally {
      isLoading = false;
      notifyListeners();
    }
  }
}