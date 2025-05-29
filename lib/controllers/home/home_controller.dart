import 'package:flutter/material.dart';
import 'package:projet_picsou/dialogs/alert_dialog_builder.dart';
import 'package:projet_picsou/exceptions/request_exception.dart';
import 'package:projet_picsou/services/group_service.dart';
import 'package:projet_picsou/services/user_service.dart';

import '../../models/group.dart';

class HomeController with ChangeNotifier {
  UserService userService;
  GroupService groupService;

  List<Group> groups = [];

  HomeController(this.userService, this.groupService);

  Future<void> initData() async {

    try {
      groups = await groupService.getAllGroups();
    } on NetworkException catch (e) {
      DialogBuilder.networkError(e.networkError);
    } catch (_) {
      DialogBuilder.appError();
    }

  }

}
