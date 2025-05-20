import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:projet_picsou/dialogs/alert_dialog_builder.dart';
import 'package:projet_picsou/exceptions/request_exception.dart';
import 'package:restart_app/restart_app.dart';
import '../models/user.dart';
import '../services/auth_service.dart';

class LoginController with ChangeNotifier {
  final AuthService authService;
  User? user;
  bool hidePassword = true;
  final emailController = TextEditingController();
  final passwordController = TextEditingController();

  LoginController(this.authService);

  void submitForm(GlobalKey<FormState> formKey) {
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
      DialogBuilder.warning("Le formulaire n'est pas valide", "Veuillez vérifier les champs du formulaire");
      return;
    }

    DialogBuilder.loading();

    try {
      await authService.login(email, password);
      Restart.restartApp();
    }  on NetworkException catch (e) {
      DialogBuilder.networkError(e.networkError);
    } catch (_) {
      DialogBuilder.appError();
    } finally {
    }
  }
}
