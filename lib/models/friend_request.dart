import 'package:projet_picsou/models/user.dart';

class FriendRequest {
  final int id;
  final User fromUser;
  final User toUser;

  const FriendRequest(
    this.id,
    this.fromUser,
    this.toUser,
  );

  factory FriendRequest.fromJson(Map<String, dynamic> json) {
    return FriendRequest(
      json['id'],
      User.fromJson(json['from_user']),
      User.fromJson(json['to_user']),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'user1_id': fromUser.id,
      'user2_id': toUser.id,
    };
  }
}
