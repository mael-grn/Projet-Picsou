import 'package:projet_picsou/models/user.dart';

class Participant {
  final int? id;
  final double amountParticipated;
  final int groupUserId;
  final int? partNumber;
  final int? expenseId;

  const Participant(
      this.id,
      this.amountParticipated,
      this.groupUserId,
      this.partNumber,
      this.expenseId,
      );

  factory Participant.fromJson(Map<String, dynamic> json) {
    return Participant(
        json['id'],
        json['amount_participated']?.toDouble() ?? 0.0,
        json['groups_users_id'],
        json['part_number'],
        json['expenses_id']
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'amount_participated': amountParticipated,
      'part_number': partNumber,
      'expenses_id': expenseId,
      'groups_users_id': groupUserId
    };
  }
}

class DetailedParticipant {
  final User user;
  final int status;
  final Participant participant;

  const DetailedParticipant(
      this.user,
      this.status,
      this.participant,
      );

  factory DetailedParticipant.fromJson(Map<String, dynamic> json) {
    return DetailedParticipant(
        User.fromJson(json['user']),
        json['status'],
        Participant.fromJson(json['participant']),
    );
  }
}