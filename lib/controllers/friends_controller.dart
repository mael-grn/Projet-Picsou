import '../models/Friend.dart';

class FriendsController {

  Future<List<Friend>> getAllFriends() async {
    await Future.delayed(Duration(seconds: 4));
    return Future.value([
      Friend(1, "Garnier", "Maël", "maelgarnier5@gmail.com", "+33 7 77 33 31 62", "FR7630001007941234567890185", 19.0),
      Friend(2, "Dupont", "Julien", "julien.dupont@gmail.com", "+33 6 12 34 56 78", "FR7630001007941234567890190", 24.5),
      Friend(3, "Leclerc", "Sophie", "sophie.leclerc@outlook.fr", "+33 7 56 78 90 12", "FR7630001007941234567890205", 22.0),
      Friend(4, "Martin", "Lucas", "lucas.martin@yahoo.fr", "+33 6 45 67 89 01", "FR7630001007941234567890210", 30.0),
      Friend(5, "Roux", "Claire", "claire.roux@gmail.com", "+33 7 22 33 44 55", "FR7630001007941234567890225", 28.0),
      Friend(6, "Pires", "David", "david.pires@orange.fr", "+33 6 99 88 77 66", "FR7630001007941234567890230", 26.5),
      Friend(7, "Lemoine", "Amélie", "amelie.lemoine@gmail.com", "+33 7 44 55 66 77", "FR7630001007941234567890245", 21.0),
      Friend(8, "Benoit", "Thomas", "thomas.benoit@icloud.com", "+33 6 11 22 33 44", "FR7630001007941234567890250", 35.0),
      Friend(9, "Carlier", "Élodie", "elodie.carlier@gmail.com", "+33 7 33 44 55 66", "FR7630001007941234567890265", 27.5),
      Friend(10, "Chevalier", "Hugo", "hugo.chevalier@yahoo.com", "+33 6 66 77 88 99", "FR7630001007941234567890270", 23.0),
      Friend(11, "Fontaine", "Marie", "marie.fontaine@free.fr", "+33 7 88 99 11 22", "FR7630001007941234567890285", 29.0),
      Friend(12, "Lemoine", "Nicolas", "nicolas.lemoine@orange.fr", "+33 6 77 88 99 00", "FR7630001007941234567890290", 32.0),
      Friend(13, "Boucher", "Isabelle", "isabelle.boucher@icloud.com", "+33 7 11 22 33 55", "FR7630001007941234567890305", 25.5),
      Friend(14, "Girard", "Pierre", "pierre.girard@gmail.com", "+33 6 33 44 55 77", "FR7630001007941234567890310", 33.5),
      Friend(15, "Moreau", "Valérie", "valerie.moreau@yahoo.com", "+33 7 99 11 22 33", "FR7630001007941234567890325", 31.0),
    ]);

  }
}