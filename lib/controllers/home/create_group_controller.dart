import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:http/http.dart';
import 'package:projet_picsou/dialogs/alert_dialog_builder.dart';
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
import 'home_controller.dart';

class CreateGroupController with ChangeNotifier {
  final UserService userService;
  final FriendService friendService;
  final GroupService groupService;

  final nameController = TextEditingController();
  String groupPictureUrl = "";
  List<User> users = [];
  List<UserIdWithStatus> selectedUsers = [];

  CreateGroupController(this.userService, this.friendService, this.groupService);

  void setGroupPictureUrl(String url) {
    groupPictureUrl = url;
    notifyListeners();
  }

  void addSelectedFriend(UserIdWithStatus user) {
    if (!selectedUsers.contains(user)) {
      selectedUsers.add(user);
      notifyListeners();
    }
  }

  void updateSelectedFriendStatus(int userId, UserStatus status) {
    final index = selectedUsers.indexWhere((u) => u.userId == userId);
    if (index != -1) {
      selectedUsers[index] = UserIdWithStatus(userId, status);
      notifyListeners();
    }
  }

  bool isSelected(int userId) {
    return selectedUsers.where((u) => u.userId == userId).isNotEmpty;
  }

  void removeSelectedFriend(UserIdWithStatus user) {
    selectedUsers.removeWhere((u) => u.userId == user.userId);
    notifyListeners();
  }

  Future<void> initData() async {
    DialogBuilder.loading();
    try {
      users = await friendService.getAllFriendsAsUser();
      DialogBuilder.closeCurrentDialog();
      if (users.isEmpty) {
        DialogBuilder.error(
          "Aucun ami trouvé",
            "Pour créer un groupe, vous devez d'abord ajouter des amis.",
          onCLose: () {
            CustomNavigator.back();
          }
        );
        return;
      }
      notifyListeners();
    } on NetworkException catch (e) {
      DialogBuilder.networkError(e.networkError);
    } catch (_) {
      DialogBuilder.appError();
    }
  }

  Future<void> createGroup(GlobalKey<FormState> formKey) async {
    if (!formKey.currentState!.validate()) {
      return;
    }

    if (selectedUsers.isEmpty) {
      DialogBuilder.error("Veuillez selectionner des utilisateurs", "Vous ne pouvez pas créer un groupe sans utilisateurs. Merci d'en selectionner au moins un.");
      return;
    }

    if (groupPictureUrl.isEmpty) {
      DialogBuilder.error("Veuillez selectionner une image", "Vous ne pouvez pas créer un groupe sans image. Merci d'en selectionner une.");
      return;
    }

    selectedUsers.add(UserIdWithStatus(User.getCurrentUserInstance().id, UserStatus.owner));

    DialogBuilder.loading();

    try {
      final group = GroupWithUser(
        Group(
          null,
          nameController.text,
          groupPictureUrl,
        ),
        selectedUsers,
      );
      await groupService.createGroup(group);
      DialogBuilder.closeCurrentDialog();
      CustomNavigator.back();
    } on NetworkException catch (e) {
      DialogBuilder.networkError(e.networkError);
    } catch (_) {
      DialogBuilder.appError();
    }
  }

}
