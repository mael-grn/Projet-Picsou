import 'package:projet_picsou/models/expense.dart';
import 'package:projet_picsou/models/payment.dart';
import 'package:projet_picsou/models/user.dart';

/// Controller to handle the payments.
class PaymentController {

  /// Returns the five last payments made with a friend.
  Future<List<Payment>> getFiveLastPaymentFromFriend(friendId) {

    var user1 = User(1, "Maël", "Garnier", "maelgarnier5@gmail.com", "+33 7 77 33 31 62", "FR7630001007941234567890185", "https://images.themill.tech/122fed93-7cc0-4511-b506-b4b174692ff1/dev/ed4e5617-f45a-4d58-bf9c-788cd130d644/default_avatar.png?auto=format");
    var user2 = User(2,"Julien",  "Dupont", "julien.dupont@gmail.com", "+33 6 12 34 56 78", "FR7630001007941234567890190", "https://images.themill.tech/122fed93-7cc0-4511-b506-b4b174692ff1/dev/ed4e5617-f45a-4d58-bf9c-788cd130d644/default_avatar.png?auto=format");

    return Future.value(
        [
          Expense(1, "Plein Jeep", "", [user1], [user2], 48.74, DateTime.now().subtract(Duration(minutes: 5)), 48.74),
          Expense(2, "Courses maxi", "", [user1], [user2], 17.99, DateTime.now().subtract(Duration(hours: 3)), 17.99),
          Expense(3, "Machine à laver", "", [user1], [user2], 17.99, DateTime.now().subtract(Duration(days: 2)), 17.99),
          Expense(4, "Ski", "", [user2], [user1], -70.68, DateTime.now().subtract(Duration(days: 6)), 70.68),
          Expense(5, "Alcool", "", [user1], [user2], 5.91, DateTime.now().subtract(Duration(days: 10)), 5.91),
        ]
    );
  }

  /// Returns the global balance of the user.
  Future<double> getUserBalance() async {
    await Future.delayed(Duration(seconds: 1));
    return Future.value(100);
  }
}