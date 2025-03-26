import 'user.dart';

class Friend extends User {

  final double balance;

  const Friend(super.id, super.name, super.surname, super.emailPaypal, super.telWero, super.rib, super.profilPicture, this.balance);
}