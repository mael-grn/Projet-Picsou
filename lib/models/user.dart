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
      'las_name': lastName,
      'email': email,
      'tel': tel,
      'email_paypal': emailPaypal,
      'tel_wero': telWero,
      'rib': rib,
      'profil_picture_ref': profilPictureRef,
      'password': password,
    };
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
}