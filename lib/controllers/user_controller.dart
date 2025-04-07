
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
      Friend(5, "Clara", "Roux", "clara.roux@gmail.com", "+33 7 88 99 00 11", "FR7630001007941234567890215", "https://images.themill.tech/122fed93-7cc0-4511-b506-b4b174692ff1/dev/ed4e5617-f45a-4d58-bf9c-788cd130d644/default_avatar.png?auto=format", 5.0),
      Friend(6, "Hugo", "Bernard", "hugo.bernard@laposte.net", "+33 6 23 45 67 89", "FR7630001007941234567890220", "https://images.themill.tech/122fed93-7cc0-4511-b506-b4b174692ff1/dev/ed4e5617-f45a-4d58-bf9c-788cd130d644/default_avatar.png?auto=format", -15.75),
      Friend(7, "Emma", "Moreau", "emma.moreau@gmail.com", "+33 7 12 34 56 78", "FR7630001007941234567890225", "https://images.themill.tech/122fed93-7cc0-4511-b506-b4b174692ff1/dev/ed4e5617-f45a-4d58-bf9c-788cd130d644/default_avatar.png?auto=format", 0.0),
      Friend(8, "Nathan", "Girard", "nathan.girard@gmail.com", "+33 6 98 76 54 32", "FR7630001007941234567890230", "https://images.themill.tech/122fed93-7cc0-4511-b506-b4b174692ff1/dev/ed4e5617-f45a-4d58-bf9c-788cd130d644/default_avatar.png?auto=format", 42.3),
      Friend(9, "Léa", "Lambert", "lea.lambert@hotmail.fr", "+33 7 23 45 67 89", "FR7630001007941234567890235", "https://images.themill.tech/122fed93-7cc0-4511-b506-b4b174692ff1/dev/ed4e5617-f45a-4d58-bf9c-788cd130d644/default_avatar.png?auto=format", -8.2),
      Friend(10, "Arthur", "Faure", "arthur.faure@gmail.com", "+33 6 11 22 33 44", "FR7630001007941234567890240", "https://images.themill.tech/122fed93-7cc0-4511-b506-b4b174692ff1/dev/ed4e5617-f45a-4d58-bf9c-788cd130d644/default_avatar.png?auto=format", 12.5),
      Friend(11, "Camille", "Perrin", "camille.perrin@live.fr", "+33 7 00 11 22 33", "FR7630001007941234567890245", "https://images.themill.tech/122fed93-7cc0-4511-b506-b4b174692ff1/dev/ed4e5617-f45a-4d58-bf9c-788cd130d644/default_avatar.png?auto=format", -3.0),
      Friend(12, "Thomas", "Marchand", "thomas.marchand@gmail.com", "+33 6 55 66 77 88", "FR7630001007941234567890250", "https://images.themill.tech/122fed93-7cc0-4511-b506-b4b174692ff1/dev/ed4e5617-f45a-4d58-bf9c-788cd130d644/default_avatar.png?auto=format", 60.0),
    ]);

  }

  /// Returns the friend with the given id.
  Future<Friend> getFriend(friendId) async {
    await Future.delayed(Duration(seconds: 2));
    return Future.value(Friend(1, "Maël", "Garnier", "maelgarnier5@gmail.com", "+33 7 77 33 31 62", "FR7630001007941234567890185", "https://images.themill.tech/122fed93-7cc0-4511-b506-b4b174692ff1/dev/ed4e5617-f45a-4d58-bf9c-788cd130d644/default_avatar.png?auto=format", 19.0));
  }
}