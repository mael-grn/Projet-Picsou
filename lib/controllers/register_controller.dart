import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:projet_picsou/enums/network_error_enum.dart';
import 'package:projet_picsou/exceptions/request_exception.dart';
import '../models/user.dart';
import '../services/auth_service.dart';

class RegisterController with ChangeNotifier {
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
  final lastNameController = TextEditingController();
  final firstNameController = TextEditingController();

  RegisterController(this.authService);

  void closePopup() {
    showPopup = false;
    popupTitle = null;
    popupContent = null;
    popupImage = null;
    notifyListeners();
  }

  void submitForm(GlobalKey<FormState> formKey) {
    HapticFeedback.mediumImpact();
    String lastName = lastNameController.text;
    String firstName = firstNameController.text;
    String email = emailController.text;
    String password = passwordController.text;

    register(formKey, firstName, lastName, email, password);
  }

  String? lastNameValidator(String? value) {
    if (User.checkNameFormat(value)) {
      return null;
    } else {
      return 'Format du nom invalide';
    }
  }

  String? firstNameValidator(String? value) {
    if (User.checkNameFormat(value)) {
      return null;
    } else {
      return 'Format du prénom invalide';
    }
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

  Future<void> register(
      GlobalKey<FormState> formKey,
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

      if (!formKey.currentState!.validate()) {
        return;
      }

      isLoading = true;
      error = null;
      notifyListeners();

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
    }  on NetworkException catch (e) {
      if (e.networkError.code == NetworkErrorEnum.conflict.code) {
        error = "Cet email est déjà utilisé";
        popupContent = "Cet email est déjà utilisé";
      } else {
        error = "${e.networkError.message} (${e.networkError.code})";
        popupContent = "${e.networkError.message} (${e.networkError.code})";
      }
      popupTitle = "Erreur";
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
}
