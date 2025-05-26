import 'dart:async';
import 'package:projet_picsou/utils/storage_utils.dart';
import 'package:restart_app/restart_app.dart';
import '../core/provider.dart';
import '../models/user.dart';

class SessionService {
  /// Returns the user with the given email and password.
  /// Store the token in the shared preferences.
  Future<User> openSession(String email, String password) async {
    final response = await Provider.sendRequest(route: '/session', method: HttpMethod.POST, body: {
      'email': email,
      'password': password,
    });
    User user = User.fromJson(response);
    User.setCurrentUserInstance(user);
    return user;
  }

  static Future<void> closeSession() async {
    try {
      await Provider.sendRequestWithCookies( method: HttpMethod.DELETE, route: '/session');
    } catch (_) {

    }
    StorageUtils.remove("token");
    User.removeCurrentUserInstance();
    await Restart.restartApp();
  }
}
