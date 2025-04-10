import 'package:flutter/material.dart';
import 'package:projet_picsou/exceptions/request_exception.dart';
import '../models/user.dart';
import '../services/auth_service.dart';

class AuthController with ChangeNotifier {
  final AuthService authService;
  User? user;
  bool showPopup = false;
  String? popupTitle;
  String? popupContent;
  String? popupImage;
  bool isLoading = false;
  String? error;

  AuthController({required this.authService});

  void closePopup() {
    showPopup = false;
    popupTitle = null;
    popupContent = null;
    popupImage = null;
    notifyListeners();
  }

  String? lastNameValidator(String? value) {
    if (value == null || value.isEmpty) {
      return 'Veuillez entrer votre nom';
    }
    return null;
  }

  String? firstNameValidator(String? value) {
    if (value == null || value.isEmpty) {
      return 'Veuillez entrer votre prénom';
    }
    return null;
  }

  String? emailValidator(String? value) {
    if (User.checkEmailFormat(value)) {
      return null;
    } else {
      return 'Veuillez entrer un email valide';
    }
  }

  String? passwordValidator(String? value) {
    if (User.checkPasswordFormat(value)) {
      return null;
    } else {
      return 'Le mot de passe doit contenir au moins 1 lettre majuscule, 1 lettre minuscule, 1 chiffre, 1 caractère spécial (@, \$, !, %, *, ?, &) et doit contenir au moins 8 caractères';
    }
  }

  Future<void> login(String email, String password) async {
    isLoading = true;
    error = null;
    notifyListeners();

    try {
      user = await authService.login(email, password);
      User.setCurrentUserInstance(user!);
      popupTitle = "Bravo !";
      popupContent = "Vous vous êtes souvenu de votre mot de passe, c'est pas donné à tout le monde.";
      popupImage = "images/thumbs_up.png";
      showPopup = true;
    }  on RequestException catch (e) {
      error = e.message;
      popupTitle = "Erreur";
      popupContent = e.message;
      popupImage = "images/error.png";
      showPopup = true;
    } catch (_) {
      error = "Erreur serveur";
      popupTitle = "Erreur";
      popupContent = "Erreur de l'application";
      popupImage = "images/error.png";
      showPopup = true;
    } finally {
      isLoading = false;
      notifyListeners();

    }
  }

  Future<void> register(
      String firstName,
      String lastName,
      String email,
      String password, {
        String tel = "",
        String emailPaypal = "",
        String telWero = "",
        String rib = "",
        String profilPictureRef = "",
      }) async {
    isLoading = true;
    error = null;
    notifyListeners();

    try {
      user = await authService.register(
        firstName,
        lastName,
        email,
        password,
        tel,
        emailPaypal,
        telWero,
        rib,
        profilPictureRef,
      );
      User.setCurrentUserInstance(user!);
      popupTitle = "Bienvenu !";
      popupContent = "Vous venez de vous inscrire sur Picsou. Cliquez sur continuer pour plonger dans un univers fascinant.";
      popupImage = "images/thumbs_up.png";
      showPopup = true;
    }  on RequestException catch (e) {
      error = e.message;
      popupTitle = "Erreur";
      popupContent = e.message;
      popupImage = "images/error.png";
      showPopup = true;
    } catch (_) {
      // cas ou il n'y a pas de token
      error = "Erreur dans l'application";
      popupTitle = "Erreur";
      popupContent = "Erreur de l'application";
      popupImage = "images/error.png";
      showPopup = true;
    }  finally {
      isLoading = false;
      notifyListeners();
    }
  }

  Future<void> loadUser() async {
    error = null;
    isLoading = true;
    notifyListeners();

    try {
      user = await authService.verifyToken();
      User.setCurrentUserInstance(user!);
    }catch (_) {
    } finally {
      isLoading = false;
      notifyListeners();
    }
  }
}
