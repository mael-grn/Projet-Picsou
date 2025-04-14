import 'package:projet_picsou/models/User_Group.dart';

class Group {

  final int id;
  final String name;
  final String profilPicture;
  final List<UserGroup> users;

  const Group(this.id, this.name, this.users, this.profilPicture);

  factory Group.fromJson(Map<String, dynamic> json) {
    return Group(
        json['id'],
        json['name'],
        json['users'],
        json['profile_pict_ref']
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'users': users,
      'profile_pict_ref': profilPicture,
    };
  }
}