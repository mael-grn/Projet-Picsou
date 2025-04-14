import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:projet_picsou/enums/network_error_enum.dart';
import 'package:projet_picsou/exceptions/request_exception.dart';
import '../models/user.dart';
import '../services/auth_service.dart';

class LoginController with ChangeNotifier {
  final AuthService authService;
  User? user;
  bool showPopup = false;
  String? popupTitle;
  String? popupContent;
  String? popupImage;
  bool hidePassword = true;
  bool isLoading = false;
  String? error;
  final emailController = TextEditingController();
  final passwordController = TextEditingController();

  LoginController(this.authService);

  void closePopup() {
    showPopup = false;
    popupTitle = null;
    popupContent = null;
    popupImage = null;
    notifyListeners();
  }

  void submitForm(GlobalKey<FormState> formKey) {
    HapticFeedback.mediumImpact();

    String email = emailController.text;
    String password = passwordController.text;

    login(formKey, email, password);
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

  void togglePasswordVisibility() {
    hidePassword = !hidePassword;
    notifyListeners();
  }

  Future<void> login(GlobalKey<FormState> formKey, String email, String password) async {

    if (!formKey.currentState!.validate()) {
      return;
    }

    isLoading = true;
    error = null;
    notifyListeners();

    try {
      user = await authService.login(email, password);
      popupTitle = "Bravo !";
      popupContent = "Vous vous êtes souvenu de votre mot de passe, c'est pas donné à tout le monde.";
      popupImage = "images/thumbs_up.png";
      showPopup = true;
    }  on NetworkException catch (e) {
      if (e.networkError == NetworkErrorEnum.unauthorized || e.networkError == NetworkErrorEnum.notFound) {
        error = "Email ou mot de passe incorrect";
        popupContent = "Email ou mot de passe incorrect";
      } else {
        error = "${e.networkError.message} (${e.networkError.code})";
        popupContent = "${e.networkError.message} (${e.networkError.code})";
      }
      popupTitle = "Erreur";
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
}
