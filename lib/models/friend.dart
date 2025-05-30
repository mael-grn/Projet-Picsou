import 'package:projet_picsou/models/user.dart';

class Friend {
  final int id;
  final User user1;
  final User user2;

  const Friend(
    this.id,
    this.user1,
    this.user2,
  );

  factory Friend.fromJson(Map<String, dynamic> json) {
    return Friend(
      json['id'],
      User.fromJson(json['user1']),
      User.fromJson(json['user2']),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'user1_id': user1.id,
      'user2_id': user2.id,
    };
  }
}
