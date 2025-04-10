
import 'package:projet_picsou/controllers/user_controller.dart';
import 'package:projet_picsou/models/User_Group.dart';
import 'package:projet_picsou/models/group.dart';
import 'package:projet_picsou/models/user.dart';

import '../models/friend.dart';

class GroupController {

  /// Returns all the friends of the user.
  Future<List<Group>> getAllGroups() async {
    UserController userController = UserController();
    List<UserGroup> users = userController.getAllUsers();
    await Future.delayed(Duration(seconds: 2));
    return Future.value([
      Group(1, "Maël", users, "https://images.themill.tech/122fed93-7cc0-4511-b506-b4b174692ff1/dev/ed4e5617-f45a-4d58-bf9c-788cd130d644/default_avatar.png?auto=format"),
      Group(2,"Julien",  users, "https://images.themill.tech/122fed93-7cc0-4511-b506-b4b174692ff1/dev/ed4e5617-f45a-4d58-bf9c-788cd130d644/default_avatar.png?auto=format"),
      Group(3,"Les vacances de Picsou",  users, "https://images.themill.tech/122fed93-7cc0-4511-b506-b4b174692ff1/dev/ed4e5617-f45a-4d58-bf9c-788cd130d644/default_avatar.png?auto=format"),
      Group(4, "Flash McQeen", users, "https://images.themill.tech/122fed93-7cc0-4511-b506-b4b174692ff1/dev/ed4e5617-f45a-4d58-bf9c-788cd130d644/default_avatar.png?auto=format"),
    ]);
  }

  /// Returns the friend with the given id.
  Future<Friend> getFriend(friendId) async {
    await Future.delayed(Duration(seconds: 2));
    return Future.value(Friend(1, "Maël", "Garnier", "maelgarnier5@gmail.com", "+33 7 77 33 31 62", "FR7630001007941234567890185", "https://images.themill.tech/122fed93-7cc0-4511-b506-b4b174692ff1/dev/ed4e5617-f45a-4d58-bf9c-788cd130d644/default_avatar.png?auto=format", 19.0));
  }
}