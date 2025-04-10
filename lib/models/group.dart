import 'package:projet_picsou/models/User_Group.dart';

class Group {

  final int id;
  final String name;
  final String profilPicture;
  final List<UserGroup> users;

  const Group(this.id, this.name, this.users, this.profilPicture);
}