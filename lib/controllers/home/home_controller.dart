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
    DialogBuilder.loading();
    groups.clear();
    try {
      List<Group> tmpGroups = await groupService.getAllGroups();
      for (Group group in tmpGroups) {
        print(group.name);
        Group newGroup = await groupService.tryGetGroupDataFromDiscussion(group);
        groups.add(newGroup);
      }
      DialogBuilder.closeCurrentDialog();
      notifyListeners();
    } on NetworkException catch (e) {
      DialogBuilder.networkError(e.networkError);
    } catch (_) {
      DialogBuilder.appError();
    }

  }

}
