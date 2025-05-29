import 'package:flutter/material.dart';
import 'package:projet_picsou/dialogs/alert_dialog_builder.dart';
import 'package:projet_picsou/exceptions/request_exception.dart';
import 'package:restart_app/restart_app.dart';
import '../../core/custom_navigator.dart';
import '../../models/user.dart';
import '../../services/session_service.dart';
import '../../views/auth/select_profile_picture_view.dart';

class LoginController with ChangeNotifier {
  final SessionService authService;
  User? user;
  bool hidePassword = true;
  final emailController = TextEditingController();
  final passwordController = TextEditingController();

  LoginController(this.authService);

  void submitForm(GlobalKey<FormState> formKey) {
    String email = emailController.text.trim();
    String password = passwordController.text.trim();

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
      final user = await authService.openSession(email, password);
      if (user.profilPictureRef.isEmpty) {
        DialogBuilder.closeCurrentDialog();
        CustomNavigator.pushFromBottom(SelectProfilePictureView());
        return;
      } else {
        DialogBuilder.closeCurrentDialog();
        await Restart.restartApp();
        return;
      }
    }  on NetworkException catch (e) {
      DialogBuilder.networkError(
          e.networkError,
        personalizedErrors: [
          (code: 404, message: "Email ou mot de passe incorrect", title: "Erreur de connexion"),
          (code: 403, message: "Email ou mot de passe incorrect", title: "Erreur de connexion"),
        ]
      );
    } catch (e) {
      print(e);
      DialogBuilder.appError();
    } finally {
    }
  }
}
