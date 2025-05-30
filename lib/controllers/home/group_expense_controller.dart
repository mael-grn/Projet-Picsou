import 'package:flutter/material.dart';
import 'package:projet_picsou/dialogs/alert_dialog_builder.dart';
import 'package:projet_picsou/exceptions/request_exception.dart';
import 'package:projet_picsou/models/expense.dart';
import 'package:projet_picsou/models/user.dart';
import 'package:projet_picsou/services/expense_service.dart';
import 'package:projet_picsou/services/group_service.dart';
import 'package:projet_picsou/services/user_service.dart';

import '../../models/group.dart';

class GroupExpenseController with ChangeNotifier {
  UserService userService;
  GroupService groupService;
  ExpenseService expenseService;
  Group? group;
  List<User> users = [];
  List<VeryDetailedExpense> expenses = [];

  GroupExpenseController(this.userService, this.groupService, this.expenseService);

  Future<void> initData(Group group) async {
    DialogBuilder.loading();
    try {
      this.group = await groupService.tryGetGroupDataFromDiscussion(group);
      users = await groupService.getUsersFromGroup(group.id!);
      expenses = await expenseService.getExpensesFromGroup(group.id!);
      DialogBuilder.closeCurrentDialog();
      notifyListeners();
    } on NetworkException catch (e) {
      DialogBuilder.networkError(e.networkError);
    } catch (_) {
      DialogBuilder.appError();
    }

  }

}
