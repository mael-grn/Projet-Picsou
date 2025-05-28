import 'package:projet_picsou/models/user.dart';

class Group {
  final int id;
  final String name;
  final String pictRef;

  const Group(
      this.id,
      this.name,
      this.pictRef,
      );

  factory Group.fromJson(Map<String, dynamic> json) {
    return Group(
      json['id'],
      json['name'],
      json['pict_ref'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'pict_ref': pictRef,
    };
  }

  static bool checkNameFormat(String? name) {
    if (name == null ||
        name.isEmpty ||
        name.length < 2 ||
        name.length > 50 ||
        name.contains(" ")) {
      return false;
    }
    return true;
  }

  static String? checkNameFormatValidator(String? name) =>
      checkNameFormat(name)
          ? null
          : "Le nom doit contenir entre 2 et 50 caractères et ne doit pas contenir d'espaces.";


}
class GroupWithUser {
  final Group group;
  final List<User> users;

  const GroupWithUser(
      this.group,
      this.users,
      );

  factory GroupWithUser.fromJson(Map<String, dynamic> json) {
    return GroupWithUser(
      Group.fromJson(json['group']),
      (json['users'] as List).map((user) => User.fromJson(user)).toList(),
    );
  }
}
