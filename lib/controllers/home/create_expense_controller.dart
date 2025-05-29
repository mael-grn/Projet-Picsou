import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:http/http.dart';
import 'package:projet_picsou/dialogs/alert_dialog_builder.dart';
import 'package:projet_picsou/enums/expense_type_enum.dart';
import 'package:projet_picsou/exceptions/request_exception.dart';
import 'package:projet_picsou/models/group.dart';
import 'package:projet_picsou/services/friend_service.dart';
import 'package:projet_picsou/services/user_service.dart';
import 'package:provider/provider.dart';
import '../../core/custom_navigator.dart';
import '../../main.dart';
import '../../models/friend.dart';
import '../../models/user.dart';
import '../../services/group_service.dart';

class CreateExpenseController with ChangeNotifier {

  //services
  final UserService userService;
  final FriendService friendService;
  final GroupService groupService;

  //values
  final nameController = TextEditingController();
  final descriptionController = TextEditingController();
  final dateController = TextEditingController();
  final amountController = TextEditingController();
  final stockPartsController = TextEditingController();

  ExpenseTypeEnum expenseType = ExpenseTypeEnum.amount;

  List<User> contributors = [];
  List<User> participants = [];
  List<Group> groups = [];

  List<User> friends = [];


  CreateExpenseController(this.userService, this.friendService, this.groupService);



}
