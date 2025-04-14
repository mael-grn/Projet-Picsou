import 'dart:async';
import 'package:projet_picsou/enums/network_error_enum.dart';
import '../core/provider.dart';
import '../exceptions/request_exception.dart';
import '../models/user.dart';
import '../utils/token_utils.dart';

class AuthService {
  /// Returns the user with the given email and password.
  /// Store the token in the shared preferences.
  Future<User> login(String email, String password) async {
    final response = await Provider.postUnsecure('/auth/login', {
      'email': email,
      'password': password,
    });

    await TokenUtils.saveToken(response['token']);
    User user = User.fromJson(response['user']);
    User.setCurrentUserInstance(user);
    return user;
  }

  /// Create the user in the database for the given user.
  Future<User> register(
    String firstName,
    String lastName,
    String email,
    String password,
    String tel,
    String emailPaypal,
    String telWero,
    String rib,
    String profilPictureRef,
  ) async {
    final response = await Provider.postUnsecure('/auth/register', {
      'first_name': firstName,
      'last_name': lastName,
      'email': email,
      'password': password,
      'tel': tel,
      'email_paypal': emailPaypal,
      'tel_wero': telWero,
      'rib': rib,
      'profil_pict_ref': profilPictureRef,
    });

    await TokenUtils.saveToken(response['token']);
    User user = User.fromJson(response['user']);
    User.setCurrentUserInstance(user);
    return user;
  }

  /// Returns true if the token is valid, false otherwise.
  /// May throw a RequestException.
  Future<User> validateToken() async {
    try {
      final response = await Provider.getSecure('/auth/validate');
      User user = User.fromJson(response['user']);
      User.setCurrentUserInstance(user);
      return user;
    } on NetworkException catch (e) {
      if (e.networkError == NetworkErrorEnum.unauthorized) {
        TokenUtils.removeToken();
        User.removeCurrentUserInstance();
      }
      rethrow;
    }
  }
}
