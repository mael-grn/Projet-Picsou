import 'package:projet_picsou/models/expense.dart';

class ExpenseEvo extends Expense {

  final int sharesNumber;

  ExpenseEvo(super.id, super.name, super.description, super.contributors, super.participants, super.myShare, super.date, super.amount, {this.sharesNumber = 1});
}