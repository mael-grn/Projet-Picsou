import '../core/provider.dart';
import '../models/expense.dart';

class ExpenseService {

  Future<Expense> createExpense(Expense expense) async {
    final response = await Provider.postSecure('/expenses', expense.toJson());
    return Expense.fromJson(response['expense']);
  }

  Future<Expense> getExpenseFromId(int expenseId) async {
    final response = await Provider.getSecure('/expenses/$expenseId');
    return Expense.fromJson(response['expense']);
  }

  Future<void> updateExpense(Expense expense) async {
    await Provider.putSecure('/expenses/${expense.id}', expense.toJson());
  }

  Future<void> deleteExpense(int expenseId) async {
    await Provider.deleteSecure('/expenses/$expenseId', {});
  }
}