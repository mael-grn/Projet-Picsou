import 'user.dart';

class Friend extends User {

  final double balance;

  const Friend(super.id, super.firstName, super.lastName, super.email, super.tel, super.emailPaypal, super.telWero, super.rib, super.profilPictureRef, super.password, this.balance);
}