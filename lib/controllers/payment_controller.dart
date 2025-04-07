import 'package:projet_picsou/models/expense.dart';
import 'package:projet_picsou/models/payment.dart';
import 'package:projet_picsou/models/refund.dart';
import 'package:projet_picsou/models/user.dart';

/// Controller to handle the payments.
class PaymentController {

  /// Returns the five last payments made with a friend.
  Future<List<Payment>> getFiveLastPaymentFromFriend(friendId) async {

    var user1 = User(1, "Maël", "Garnier", "maelgarnier5@gmail.com", "+33 7 77 33 31 62", "FR7630001007941234567890185", "https://images.themill.tech/122fed93-7cc0-4511-b506-b4b174692ff1/dev/ed4e5617-f45a-4d58-bf9c-788cd130d644/default_avatar.png?auto=format");
    var user2 = User(2,"Julien",  "Dupont", "julien.dupont@gmail.com", "+33 6 12 34 56 78", "FR7630001007941234567890190", "https://images.themill.tech/122fed93-7cc0-4511-b506-b4b174692ff1/dev/ed4e5617-f45a-4d58-bf9c-788cd130d644/default_avatar.png?auto=format");

    await Future.delayed(Duration(seconds: 2));

    return Future.value(
        [
          Expense(1, "Plein Jeep", "", [user1], [user2], 48.74, DateTime.now().subtract(Duration(minutes: 5)), 48.74),
          Expense(2, "Courses maxi", "", [user1], [user2], 17.99, DateTime.now().subtract(Duration(hours: 3)), 17.99),
          Refund(3, DateTime.now().subtract(Duration(days: 2)), 17.99, user2, user1),
          Expense(4, "Ski", "", [user2], [user1], -70.68, DateTime.now().subtract(Duration(days: 6)), 70.68),
          Expense(5, "Alcool", "", [user1], [user2], 5.91, DateTime.now().subtract(Duration(days: 10)), 5.91),
        ]
    );
  }

  /// Returns all the last payments made with a friend.
  Future<List<Payment>> getLastPaymentFromFriend(friendId) async {
    var user1 = User(1, "Maël", "Garnier", "maelgarnier5@gmail.com", "+33 7 77 33 31 62", "FR7630001007941234567890185", "https://images.themill.tech/122fed93-7cc0-4511-b506-b4b174692ff1/dev/ed4e5617-f45a-4d58-bf9c-788cd130d644/default_avatar.png?auto=format");
    var user2 = User(2, "Julien", "Dupont", "julien.dupont@gmail.com", "+33 6 12 34 56 78", "FR7630001007941234567890190", "https://images.themill.tech/122fed93-7cc0-4511-b506-b4b174692ff1/dev/ed4e5617-f45a-4d58-bf9c-788cd130d644/default_avatar.png?auto=format");

    await Future.delayed(Duration(seconds: 2));

    return Future.value([
      Expense(1, "Plein Jeep", "", [user1], [user2], 48.74, DateTime.now().subtract(Duration(minutes: 5)), 48.74),
      Expense(2, "Courses Maxi", "", [user1], [user2], 17.99, DateTime.now().subtract(Duration(hours: 3)), 17.99),
      Refund(3, DateTime.now().subtract(Duration(days: 2)), 17.99, user2, user1),
      Expense(4, "Ski", "", [user2], [user1], -70.68, DateTime.now().subtract(Duration(days: 6)), 70.68),
      Expense(5, "Alcool", "", [user1], [user2], 5.91, DateTime.now().subtract(Duration(days: 10)), 5.91),
      Expense(6, "Dîner au restaurant", "Pizza et boissons", [user1], [user2], 35.50, DateTime.now().subtract(Duration(days: 1, hours: 5)), 35.50),
      Expense(7, "Café", "Pause café du matin", [user2], [user1], -3.20, DateTime.now().subtract(Duration(days: 1, hours: 10)), 3.20),
      Expense(8, "Hôtel week-end", "2 nuits à Lyon", [user1], [user2], 120.00, DateTime.now().subtract(Duration(days: 7)), 120.00),
      Refund(9, DateTime.now().subtract(Duration(days: 8)), 50.00, user2, user1),
      Expense(10, "Cinéma", "Séance IMAX", [user2], [user1], -14.99, DateTime.now().subtract(Duration(days: 9)), 14.99),
      Expense(11, "Essence", "Plein d'essence pour le voyage", [user1], [user2], 65.20, DateTime.now().subtract(Duration(days: 12)), 65.20),
      Expense(12, "Courses Lidl", "Petites courses", [user2], [user1], -24.75, DateTime.now().subtract(Duration(days: 13)), 24.75),
      Refund(13, DateTime.now().subtract(Duration(days: 15)), 20.00, user1, user2),
      Expense(14, "Abonnement Netflix", "Mensualité", [user1], [user2], 8.99, DateTime.now().subtract(Duration(days: 20)), 8.99),
      Expense(15, "Billets de train", "Aller-retour Paris", [user2], [user1], -89.00, DateTime.now().subtract(Duration(days: 22)), 89.00),
    ]);
  }


  /// Returns the global balance of the user.
  Future<double> getUserBalance() async {
    await Future.delayed(Duration(seconds: 1));
    return Future.value(100);
  }
}