import 'package:projet_picsou/models/payment.dart';
import 'user.dart';

class Expense extends Payment {

  final String name;
  final String description;
  final List<User> contributors;
  final List<User> participants;
  final double myShare;

  Expense(super.id, this.name, this.description, this.contributors, this.participants, this.myShare, super.date, super.amount);
}