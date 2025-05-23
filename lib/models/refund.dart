import 'package:projet_picsou/models/user.dart';
import 'package:projet_picsou/models/payment.dart';

import '../enums/refund_status_enum.dart';

class Refund extends Payment {

  final RefundStatusEnum status;
  final User from;
  final User to;

  Refund(super.id, super.date, super.amount, this.from, this.to, {this.status = RefundStatusEnum.waiting});

  factory Refund.fromJson(Map<String, dynamic> json) {
    return Refund(
      json['id'],
      DateTime.parse(json['date']),
      json['amount'],
      User.fromJson(json['from']),
      User.fromJson(json['to']),
      status: RefundStatusEnum.values.firstWhere((e) => e.name == json['status']),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'date': date.toIso8601String(),
      'amount': amount,
      'from': from.toJson(),
      'to': to.toJson(),
      'status': status.name,
    };
  }
}