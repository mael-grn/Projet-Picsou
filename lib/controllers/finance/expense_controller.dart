import 'package:flutter/cupertino.dart';

class Expense extends ChangeNotifier {
  final String id;
  final String name;
  final double amount;
  final String date;
  final String friendId;
  final String userId;

  Expense({
    required this.id,
    required this.name,
    required this.amount,
    required this.date,
    required this.friendId,
    required this.userId,
  });

  factory Expense.fromJson(Map<String, dynamic> json) {
    return Expense(
      id: json['id'],
      name: json['name'],
      amount: json['amount'],
      date: json['date'],
      friendId: json['friendId'],
      userId: json['userId'],
    );
  }
}