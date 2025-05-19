import '../core/provider.dart';
import '../models/expense.dart';
import '../models/expense_evo.dart';
import '../models/payment.dart';
import '../models/refund.dart';
import '../models/user.dart';

class FriendService {

  Future<void> addFriend(userId) async {
    await Provider.postSecure('/users/friends/$userId', {});
  }

  Future<void> removeFriend(userId) async {
    await Provider.deleteSecure('/users/friends/$userId', {});
  }

  Future<double> getFriendBalance(friendId) async {
    final result = await Provider.getSecure('/users/friends/balance/$friendId');
    return result['balance'];
  }

  Future<List<User>> getFriends() async {
    return [];
    final response = await Provider.getSecure('/users/friends');
    return response['friends'].map<User>((json) => User.fromJson(json)).toList();
  }

  Future<List<Payment>> getLastPaymentFromFriend(friendId) async {
    final response = await Provider.getSecure('/users/friends');
    List<Payment> payments = [];
    for (var paymentData in response['payments']) {
      if (paymentData['friendId'] == friendId) {
        switch (paymentData['type'] as String?) {
          case 'Expense':
            payments.add(Expense.fromJson(paymentData));
            break;
          case 'ExpenseEvo':
            payments.add(ExpenseEvo.fromJson(paymentData));
            break;
          case 'Refund':
            payments.add(Refund.fromJson(paymentData));
            break;
        }
      }
    }
    return payments;
  }
}