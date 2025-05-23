import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:projet_picsou/enums/network_error_enum.dart';
import 'package:projet_picsou/exceptions/request_exception.dart';
import 'package:projet_picsou/views/select_profile_picture_view.dart';
import 'package:restart_app/restart_app.dart';
import '../core/PageRoute.dart';
import '../dialogs/alert_dialog_builder.dart';
import '../models/user.dart';
import '../services/auth_service.dart';

class RegisterController with ChangeNotifier {
  final AuthService authService;
  User? user;
  bool hidePassword = true;
  final emailController = TextEditingController();
  final passwordController = TextEditingController();
  final lastNameController = TextEditingController();
  final firstNameController = TextEditingController();

  RegisterController(this.authService);

  void submitForm(GlobalKey<FormState> formKey) {
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

    if (!formKey.currentState!.validate()) {
      DialogBuilder.warning("Le formulaire n'est pas valide", "Veuillez vérifier les champs du formulaire");
      return;
    }

    DialogBuilder.loading();

    try {

      await authService.register(
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
      DialogBuilder.closeCurrentDialog();
      PageRouter.push(SelectProfilePictureView());
    }  on NetworkException catch (e) {
      DialogBuilder.networkError(e.networkError);
    } catch (_) {
      DialogBuilder.appError();
    }
  }
}
