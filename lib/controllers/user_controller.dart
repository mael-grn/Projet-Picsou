
import 'package:projet_picsou/models/User_Group.dart';
import 'package:projet_picsou/models/user.dart';

import '../models/friend.dart';

class UserController {

  /// Returns all the friends of the user.
  Future<List<Friend>> getAllFriends() async {
    await Future.delayed(Duration(seconds: 2));
    return Future.value([
      Friend(1, "Maël", "Garnier", "maelgarnier5@gmail.com", "+33 7 77 33 31 62", "FR7630001007941234567890185", "https://images.themill.tech/122fed93-7cc0-4511-b506-b4b174692ff1/dev/ed4e5617-f45a-4d58-bf9c-788cd130d644/default_avatar.png?auto=format", 19.0),
      Friend(2,"Julien",  "Dupont", "julien.dupont@gmail.com", "+33 6 12 34 56 78", "FR7630001007941234567890190", "https://images.themill.tech/122fed93-7cc0-4511-b506-b4b174692ff1/dev/ed4e5617-f45a-4d58-bf9c-788cd130d644/default_avatar.png?auto=format", -24.5),
      Friend(3,"Sophie",  "Leclerc", "sophie.leclerc@outlook.fr", "+33 7 56 78 90 12", "FR7630001007941234567890205", "https://images.themill.tech/122fed93-7cc0-4511-b506-b4b174692ff1/dev/ed4e5617-f45a-4d58-bf9c-788cd130d644/default_avatar.png?auto=format", -22.0),
      Friend(4, "Lucas", "Martin", "lucas.martin@yahoo.fr", "+33 6 45 67 89 01", "FR7630001007941234567890210", "https://images.themill.tech/122fed93-7cc0-4511-b506-b4b174692ff1/dev/ed4e5617-f45a-4d58-bf9c-788cd130d644/default_avatar.png?auto=format", 30.0),
    ]);
  }

   List<UserGroup> getAllUsers() {
    
    User a = User(1, "Maël", "Garnier", "maelgarnier5@gmail.com", "+33 7 77 33 31 62", "FR7630001007941234567890185", "https://images.themill.tech/122fed93-7cc0-4511-b506-b4b174692ff1/dev/ed4e5617-f45a-4d58-bf9c-788cd130d644/default_avatar.png?auto=format");
    User b = User(2,"Julien",  "Dupont", "julien.dupont@gmail.com", "+33 6 12 34 56 78", "FR7630001007941234567890190", "https://images.themill.tech/122fed93-7cc0-4511-b506-b4b174692ff1/dev/ed4e5617-f45a-4d58-bf9c-788cd130d644/default_avatar.png?auto=format");
    User c = User(3,"Sophie",  "Leclerc", "sophie.leclerc@outlook.fr", "+33 7 56 78 90 12", "FR7630001007941234567890205", "https://images.themill.tech/122fed93-7cc0-4511-b506-b4b174692ff1/dev/ed4e5617-f45a-4d58-bf9c-788cd130d644/default_avatar.png?auto=format");
    User d = User(4, "Lucas", "Martin", "lucas.martin@yahoo.fr", "+33 6 45 67 89 01", "FR7630001007941234567890210", "https://images.themill.tech/122fed93-7cc0-4511-b506-b4b174692ff1/dev/ed4e5617-f45a-4d58-bf9c-788cd130d644/default_avatar.png?auto=format");
    
    return [
      UserGroup(a, "Proprio"),
      UserGroup(b, "Amis"),
      UserGroup(c, "Proprio"),
      UserGroup(d, "Amis")
    ] ;
  }

  /// Returns the friend with the given id.
  Future<Friend> getFriend(friendId) async {
    await Future.delayed(Duration(seconds: 2));
    return Future.value(Friend(1, "Maël", "Garnier", "maelgarnier5@gmail.com", "+33 7 77 33 31 62", "FR7630001007941234567890185", "https://images.themill.tech/122fed93-7cc0-4511-b506-b4b174692ff1/dev/ed4e5617-f45a-4d58-bf9c-788cd130d644/default_avatar.png?auto=format", 19.0));
  }
}