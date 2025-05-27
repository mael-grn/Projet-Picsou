import 'package:flutter/material.dart';
import 'package:projet_picsou/exceptions/request_exception.dart';
import 'package:projet_picsou/services/user_service.dart';
import 'package:projet_picsou/views/select_profile_picture_view.dart';
import '../core/theme/custom_navigator.dart';
import '../dialogs/alert_dialog_builder.dart';
import '../models/user.dart';

class RegisterController with ChangeNotifier {
  final UserService userService;
  User? user;
  bool hidePassword = true;
  final emailController = TextEditingController();
  final passwordController = TextEditingController();
  final lastNameController = TextEditingController();
  final firstNameController = TextEditingController();

  RegisterController(this.userService);

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
      await userService.createUser(
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
      CustomNavigator.push(SelectProfilePictureView());
    }  on NetworkException catch (e) {
      DialogBuilder.networkError(
        e.networkError,
        personalizedErrors: [
          (code: 409, message: "Un compte avec cette adresse email existe déjà. Veuillez en choisir une autre, ou bien vous connecter.", title: "Cet email est déjà utilisé"),
        ]
      );
    } catch (_) {
      DialogBuilder.appError();
    }
  }
}
