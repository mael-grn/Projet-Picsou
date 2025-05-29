import 'package:projet_picsou/models/user.dart';

class Group {
  final int? id;
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
  final List<UserIdWithStatus> users;

  const GroupWithUser(
      this.group,
      this.users,
      );

  factory GroupWithUser.fromJson(Map<String, dynamic> json) {
    return GroupWithUser(
      Group.fromJson(json['group']),
      (json['users'] as List).map((user) => UserIdWithStatus.fromJson(user)).toList(),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'group': group.toJson(),
      'users': users.map((u) => u.toJson()).toList(),
    };
  }
}

enum UserStatus {
  owner(0, "Propriétaire"),
  admin(1, "Administrateur"),
  trustedDelegate(2, "Participant de confiance"),
  delegate(3, "Participant"),
  member(4, "Membre"),
  spectator(5, "Spectateur");

  final int statusId;
  final String title;

  const UserStatus(this.statusId, this.title);

  factory UserStatus.fromJson(int statusId) {
    return UserStatus.values.firstWhere(
      (status) => status.statusId == statusId,
      orElse: () => UserStatus.member,
    );
  }
}

class UserIdWithStatus {
  final int userId;
  final UserStatus status;

  const UserIdWithStatus(
      this.userId,
      this.status,
      );

  factory UserIdWithStatus.fromJson(Map<String, dynamic> json) {
    return UserIdWithStatus(
      json['id_user'],
      json['status'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id_user': userId,
      'status': status.statusId,
    };
  }
}

class UserWithStatus {
  final User user;
  final UserStatus status;
  final int groupUserId;

  const UserWithStatus(
      this.user,
      this.status,
      this.groupUserId,
      );

  factory UserWithStatus.fromJson(Map<String, dynamic> json) {
    return UserWithStatus(
      User.fromJson(json['user']),
      UserStatus.fromJson(json['status']),
      json['group_user_id'] as int,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'user': user.toJson(),
      'status': status.statusId,
    };
  }
}