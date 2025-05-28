import 'dart:convert';

import '../core/provider.dart';
import '../enums/network_error_enum.dart';
import '../exceptions/request_exception.dart';
import '../models/user.dart';

class UserService {

  Future<User> getUserFromId(int userId) async {
    final response = await Provider.sendRequestWithCookies(route: '/user/$userId', method: HttpMethod.GET);
    return User.fromJson(jsonDecode(response));
  }

  Future<User> getUserFromEmail(String email) async {
    final response = await Provider.sendRequestWithCookies(route : '/user/email/$email', method: HttpMethod.GET);
    return User.fromJson(jsonDecode(response));
  }

  /// Create the user in the database for the given user.
  Future<User> createUser(
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
    final response = await Provider.sendRequest(route: '/user', method: HttpMethod.POST, body: {
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
    User user = User.fromJson(jsonDecode(response));
    User.setCurrentUserInstance(user);
    return user;
  }

  Future<User> updateUser(User user) async {
    try {
      final response = await Provider.sendRequestWithCookies(route: '/me', method: HttpMethod.PUT, body: user.toJson());
      final newUser = User.fromJson(jsonDecode(response));
      User.setCurrentUserInstance(newUser);
      return newUser;
    } on NetworkException catch (_) {
      rethrow;
    }
  }

  /// Returns true if the token is valid, false otherwise.
  /// May throw a RequestException.
  Future<User> getConnectedUser() async {
    try {
      final response = await Provider.sendRequestWithCookies(route: '/me', method: HttpMethod.GET);
      User user = User.fromJson(jsonDecode(response));
      User.setCurrentUserInstance(user);
      return user;
    } on NetworkException catch (e) {
      if (e.networkError == NetworkErrorEnum.unauthorized) {
        User.removeCurrentUserInstance();
      }
      rethrow;
    }
  }

  Future<void> deleteUser(int userId) async {
    await Provider.sendRequestWithCookies(route: '/me', method: HttpMethod.DELETE);
  }
}