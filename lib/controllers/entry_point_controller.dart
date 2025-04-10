import 'package:flutter/material.dart';
import '../exceptions/request_exception.dart';
import '../models/user.dart';
import '../services/auth_service.dart';
import '../views/splash_screen_view.dart';
import '../widgets/global_layout.dart';

class EntryPointController with ChangeNotifier {
  bool showPopup = false;
  String? popupTitle;
  String? popupContent;
  String? popupImage;
  Widget? page;
  AuthService authService;

  EntryPointController(this.authService);

  void closePopup() {
    showPopup = false;
    popupTitle = null;
    popupContent = null;
    popupImage = null;
    notifyListeners();
  }

  Future<void> checkToken() async {
    try {
      User user = await authService.verifyToken();
      User.setCurrentUserInstance(user);
      page = GlobalLayout();
    } on RequestException catch (e) {
      User.removeCurrentUserInstance();
      if (e.networkErrorCode == 500) {
        popupTitle = "Erreur serveur";
        popupContent = "Une erreur serveur est survenue. Merci de vérifier si l'application est à jour. Nous faisons tout notre possible pour résoudre le problème.";
        popupImage = "images/wondering.png";
        showPopup = true;
      } else {
        page = SplashScreenView();
      }
      // Pas besoin de notifyListeners() ici car FutureBuilder gère la reconstruction
      rethrow; // Rejeter l'erreur pour que FutureBuilder la capture
    }
    // Pas besoin de notifyListeners() dans le finally pour isLoading
  }

  void resetState() {
    showPopup = false;
    popupTitle = null;
    popupContent = null;
    popupImage = null;
    page = null;
  }
}