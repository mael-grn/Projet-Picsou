
import '../models/Friend.dart';

class UserController {

  Future<List<Friend>> getAllFriends() async {
    await Future.delayed(Duration(seconds: 2));
    return Future.value([
      Friend(1, "Maël", "Garnier", "maelgarnier5@gmail.com", "+33 7 77 33 31 62", "FR7630001007941234567890185", "https://images.ctfassets.net/h6goo9gw1hh6/2sNZtFAWOdP1lmQ33VwRN3/24e953b920a9cd0ff2e1d587742a2472/1-intro-photo-final.jpg?w=1200&h=992&q=70&fm=webp", 19.0),
      Friend(2,"Julien",  "Dupont", "julien.dupont@gmail.com", "+33 6 12 34 56 78", "FR7630001007941234567890190", "https://images.ctfassets.net/h6goo9gw1hh6/2sNZtFAWOdP1lmQ33VwRN3/24e953b920a9cd0ff2e1d587742a2472/1-intro-photo-final.jpg?w=1200&h=992&q=70&fm=webp", -24.5),
      Friend(3,"Sophie",  "Leclerc", "sophie.leclerc@outlook.fr", "+33 7 56 78 90 12", "FR7630001007941234567890205", "https://images.ctfassets.net/h6goo9gw1hh6/2sNZtFAWOdP1lmQ33VwRN3/24e953b920a9cd0ff2e1d587742a2472/1-intro-photo-final.jpg?w=1200&h=992&q=70&fm=webp", -22.0),
      Friend(4, "Lucas", "Martin", "lucas.martin@yahoo.fr", "+33 6 45 67 89 01", "FR7630001007941234567890210", "https://images.ctfassets.net/h6goo9gw1hh6/2sNZtFAWOdP1lmQ33VwRN3/24e953b920a9cd0ff2e1d587742a2472/1-intro-photo-final.jpg?w=1200&h=992&q=70&fm=webp", 30.0),
    ]);
  }

  Future<Friend> getFriend(friendId) async {
    await Future.delayed(Duration(seconds: 2));
    return Future.value(Friend(1, "Garnier", "Maël", "maelgarnier5@gmail.com", "+33 7 77 33 31 62", "FR7630001007941234567890185", "https://images.ctfassets.net/h6goo9gw1hh6/2sNZtFAWOdP1lmQ33VwRN3/24e953b920a9cd0ff2e1d587742a2472/1-intro-photo-final.jpg?w=1200&h=992&q=70&fm=webp", 19.0));
  }
}