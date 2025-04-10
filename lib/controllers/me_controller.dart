import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:projet_picsou/utils/token_utils.dart';
import '../models/user.dart';

class MeController with ChangeNotifier {
  User? user;
  bool showPopup = false;
  String? popupTitle;
  String? popupContent;
  String? popupImage;
  bool isLoading = false;
  String? error;

  MeController();

  Future<void> logout() async {
    HapticFeedback.mediumImpact();
    await TokenUtils.removeToken();
    User.removeCurrentUserInstance();
    popupTitle = "Succès";
    popupContent = "Vous vous êtes bien déconnecté. Vous allez maintenant être redirigé vers la page de connexion.";
    popupImage = "images/thumbs_up.png";
    showPopup = true;
    notifyListeners();
  }

}
