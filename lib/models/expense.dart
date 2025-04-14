import 'package:projet_picsou/models/payment.dart';
import 'user.dart';

class Expense extends Payment {

  final String name;
  final String description;
  final List<User> contributors;
  final List<User> participants;
  final double myShare;

  Expense(super.id, this.name, this.description, this.contributors, this.participants, this.myShare, super.date, super.amount);

  factory Expense.fromJson(Map<String, dynamic> json) {
    List<User> contributors = [];
    List<User> participants = [];
    for (var contributor in json['contributors']) {
      contributors.add(User.fromJson(contributor));
    }
    for (var participant in json['participants']) {
      participants.add(User.fromJson(participant));
    }
    return Expense(
      json['id'],
      json['name'],
      json['description'],
      contributors,
      participants,
      json['my_share'],
      DateTime.parse(json['date']),
      json['amount'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'description': description,
      'contributors': contributors.map((e) => e.toJson()).toList(),
      'participants': participants.map((e) => e.toJson()).toList(),
      'my_share': myShare,
      'date': date.toIso8601String(),
      'amount': amount,
    };
  }
}