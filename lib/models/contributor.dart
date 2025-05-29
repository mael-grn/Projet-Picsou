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
      json['group_user_id'],
      json['expense_id']
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