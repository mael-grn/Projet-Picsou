import 'package:projet_picsou/models/expense.dart';
import 'package:projet_picsou/models/user.dart';

class ExpenseEvo extends Expense {

  final int sharesNumber;

  ExpenseEvo(super.id, super.name, super.description, super.contributors, super.participants, super.myShare, super.date, super.amount, {this.sharesNumber = 1});

  factory ExpenseEvo.fromJson(Map<String, dynamic> json) {
    List<User> contributors = [];
    List<User> participants = [];
    for (var contributor in json['contributors']) {
      contributors.add(User.fromJson(contributor));
    }
    for (var participant in json['participants']) {
      participants.add(User.fromJson(participant));
    }
    return ExpenseEvo(
      json['id'],
      json['name'],
      json['description'],
      contributors,
      participants,
      json['my_share'],
      DateTime.parse(json['date']),
      json['amount'],
      sharesNumber: json['shares_number'],
    );
  }

  @override
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
      'shares_number': sharesNumber,
    };
  }

}