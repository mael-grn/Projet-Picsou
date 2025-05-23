import '../core/provider.dart';
import '../models/expense_evo.dart';

class ExpenseEvoService {

  Future<ExpenseEvo> createExpense(ExpenseEvo expense) async {
    final response = await Provider.postSecure('/expenses-evo', expense.toJson());
    return ExpenseEvo.fromJson(response['expense_evo']);
  }

  Future<ExpenseEvo> getExpenseFromId(int expenseId) async {
    final response = await Provider.getSecure('/expenses-evo/$expenseId');
    return ExpenseEvo.fromJson(response['expense_evo']);
  }

  Future<void> updateExpense(ExpenseEvo expense) async {
    await Provider.putSecure('/expenses-evo/${expense.id}', expense.toJson());
  }

  Future<void> deleteExpense(int expenseId) async {
    await Provider.deleteSecure('/expenses-evo/$expenseId', {});
  }
}