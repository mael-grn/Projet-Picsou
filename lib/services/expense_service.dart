import '../core/provider.dart';
import '../models/expense.dart';

class ExpenseService {

  Future<void> createExpense(DetailedExpense expense, int groupId) async {
    await Provider.sendRequestWithCookies(
        route : '/groups/$groupId/expenses',
        method: HttpMethod.POST,
        body: expense.toJson()
    );
  }
}