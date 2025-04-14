import '../core/provider.dart';
import '../models/user.dart';

class UserService {

  Future<User> getUserFromId(int userId) async {
    final response = await Provider.getSecure('/users/$userId');
    return User.fromJson(response['user']);
  }

  Future<User> getUserFromEmail(String email) async {
    final response = await Provider.getSecure('/users/email/$email');
    return User.fromJson(response['user']);
  }

  Future<double> getUserBalance(userId) async {
    return 24.46;
    final response = await Provider.getSecure('/users/$userId/balance');
    return response['balance'];
  }

  Future<User> updateUser(User user) async {
    final response = await Provider.putSecure('/users/${user.id}', user.toJson());
    return User.fromJson(response['user']);
  }

  Future<void> deleteUser(int userId) async {
    await Provider.deleteSecure('/users/$userId', {});
  }
}