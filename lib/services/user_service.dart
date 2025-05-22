import 'package:restart_app/restart_app.dart';

import '../core/provider.dart';
import '../exceptions/request_exception.dart';
import '../models/user.dart';
import '../utils/token_utils.dart';

class UserService {

  Future<User> getUserFromId(int userId) async {
    final response = await Provider.getSecure('/user/$userId');
    return User.fromJson(response['user']);
  }

  Future<User> getUserFromEmail(String email) async {
    final response = await Provider.getSecure('/user/email/$email');
    return User.fromJson(response['user']);
  }

  Future<double> getUserBalance(userId) async {
    return 24.46;
    final response = await Provider.getSecure('/users/$userId/balance');
    return response['balance'];
  }

  Future<User> updateUser(User user) async {
    try {
      final response = await Provider.putSecure('/user/', user.toJson());
      final newUser = User.fromJson(response);
      User.setCurrentUserInstance(newUser);
      return newUser;
    } on NetworkException catch (_) {
      rethrow;
    }
  }

  static Future<void> logout() async {
    await TokenUtils.removeToken();
    User.removeCurrentUserInstance();
    await Restart.restartApp();
  }

  Future<void> deleteUser(int userId) async {
    await Provider.deleteSecure('/users/$userId', {});
  }
}