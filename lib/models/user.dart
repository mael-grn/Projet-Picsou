import 'package:projet_picsou/exceptions/not_logged_in_exception.dart';

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

  static bool checkEmailFormat(String? email) {
    if (email == null || email.isEmpty) {
      return false;
    }
    final emailRegex = RegExp(r'^[\w-]+(\.[\w-]+)*@([\w-]+\.)+[a-zA-Z]{2,7}$');
    return emailRegex.hasMatch(email);
  }

  static bool checkPasswordFormat(String? password) {
    if (password == null || password.isEmpty) {
      return false;
    }
    final passwordRegex = RegExp(
        r'^(?=.*[a-z])(?=.*[A-Z])(?=.*\d)(?=.*[@$!%*?&])[A-Za-z\d@$!%*?&]{8,}$');
    return passwordRegex.hasMatch(password);
  }

  static setCurrentUserInstance(User user) {
    _currentUser = user;
  }
  static User getCurrentUserInstance() {
    if (_currentUser == null) {
      throw NotLoggedInException('No user have been set. This meen you are using this app without being logged in');
    }
    return _currentUser!;
  }
  static void removeCurrentUserInstance() {
    _currentUser = null;
  }
}