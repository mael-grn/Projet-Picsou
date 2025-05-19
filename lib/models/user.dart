import 'package:restart_app/restart_app.dart';

import '../utils/token_utils.dart';

class User {

  final int id;
  final String firstName;
  final String lastName;
  final String email;
  final String tel;
  final String emailPaypal;
  final String telWero;
  final String rib;
  final String profilPictureRef;
  final String password;

  static User? _currentUser;

  const User(
      this.id,
      this.firstName,
      this.lastName,
      this.email,
      this.tel,
      this.emailPaypal,
      this.telWero,
      this.rib,
      this.profilPictureRef,
      this.password,
      );

  factory User.fromJson(Map<String, dynamic> json) {
    return User(
      json['id'],
      json['first_name'],
      json['last_name'],
      json['email'],
      json['tel'],
      json['email_paypal'],
      json['tel_wero'],
      json['rib'],
      json['profil_pict_ref'],
      json['password'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'first_name': firstName,
      'last_name': lastName,
      'email': email,
      'tel': tel,
      'rib': rib,
      'email_paypal': emailPaypal,
      'tel_wero': telWero,
      'profil_pict_ref': profilPictureRef,
      'password': password,
    };
  }

  static bool checkNameFormat(String? name) {
    if (name == null || name.isEmpty || name.length < 2 || name.length > 50 || name.contains(" ")) {
      return false;
    }
    return true;
  }

  static String? checkNameFormatValidator(String? name) =>
      checkNameFormat(name) ? null : "Le nom doit contenir entre 2 et 50 caractères et ne doit pas contenir d'espaces.";

  static bool checkEmailFormat(String? email) {
    if (email == null || email.isEmpty) {
      return false;
    }
    final emailRegex = RegExp(r'^[\w-]+(\.[\w-]+)*@([\w-]+\.)+[a-zA-Z]{2,7}$');
    return emailRegex.hasMatch(email);
  }

  static String? checkEmailFormatValidator(String? email) =>
      checkEmailFormat(email) ? null : "Veuillez entrer un email valide.";

  static bool checkTelFormat(String? tel) {
    if (tel == null || tel.isEmpty) {
      return false;
    }
    final telRegex = RegExp(r'^\+?[0-9]{10,15}$');
    return telRegex.hasMatch(tel);
  }

  static String? checkTelFormatValidator(String? tel) =>
      checkTelFormat(tel) ? null : "Le numéro de téléphone doit contenir entre 10 et 15 chiffres.";

  static bool checkPasswordFormat(String? password) {
    if (password == null || password.isEmpty) {
      return false;
    }
    final passwordRegex = RegExp(
        r'^(?=.*[a-z])(?=.*[A-Z])(?=.*\d)(?=.*[@$!%*?&])[A-Za-z\d@$!%*?&]{8,}$');
    return passwordRegex.hasMatch(password);
  }

  static String? checkPasswordFormatValidator(String? password) =>
      checkPasswordFormat(password) ? null : "Le mot de passe doit contenir au moins 1 lettre majuscule, 1 lettre minuscule, 1 chiffre, 1 caractère spécial (@, \$, !, %, *, ?, &) et doit contenir au moins 8 caractères.";

  static setCurrentUserInstance(User user) {
    _currentUser = user;
  }
  static User getCurrentUserInstance() {
    if (_currentUser == null) {
      TokenUtils.removeToken();
      Restart.restartApp();
    }
    return _currentUser!;
  }
  static void removeCurrentUserInstance() {
    _currentUser = null;
  }
}