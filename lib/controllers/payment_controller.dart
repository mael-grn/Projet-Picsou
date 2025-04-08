import 'package:projet_picsou/models/payment.dart';


/// Controller to handle the payments.
class PaymentController {

  /// Returns the five last payments made with a friend.
  Future<List<Payment>> getFiveLastPaymentFromFriend(friendId) async {

    await Future.delayed(Duration(seconds: 2));

    return Future.value(
        [

        ]
    );
  }

  /// Returns all the last payments made with a friend.
  Future<List<Payment>> getLastPaymentFromFriend(friendId) async {

    await Future.delayed(Duration(seconds: 2));

    return Future.value([
      ]);
  }


  /// Returns the global balance of the user.
  Future<double> getUserBalance() async {
    await Future.delayed(Duration(seconds: 1));
    return Future.value(100);
  }
}