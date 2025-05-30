import 'package:projet_picsou/models/user.dart';

class Contributor {
  final int? id;
  final double amountContributed;
  final int groupUserId;
  final int? expenseId;

  const Contributor(
    this.id,
    this.amountContributed,
    this.groupUserId,
    this.expenseId,
      );

  factory Contributor.fromJson(Map<String, dynamic> json) {
    return Contributor(
      json['id'],
      json['amount_contributed']?.toDouble() ?? 0.0,
      json['groups_users_id'],
      json['expenses_id']
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'amount_contributed': amountContributed,
      'groups_users_id': groupUserId,
      'expenses_id': expenseId
    };
  }
}

class DetailedContributor {
  final User user;
  final int status;
  final Contributor contributor;

  const DetailedContributor(
      this.user,
      this.status,
      this.contributor
      );

  factory DetailedContributor.fromJson(Map<String, dynamic> json) {
    return DetailedContributor(
        User.fromJson(json['user']),
        json['status'],
        Contributor.fromJson(json['contributor'])
    );
  }
}