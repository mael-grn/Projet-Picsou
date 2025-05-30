import 'dart:convert';

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

  Future<List<VeryDetailedExpense>> getExpensesFromGroup(int groupId) async {
    final response = await Provider.sendRequestWithCookies(
        route : '/groups/$groupId/expenses',
        method: HttpMethod.GET,
    );

    return (jsonDecode(response) as List)
        .map((json) => VeryDetailedExpense.fromJson(json))
        .toList();
  }
}