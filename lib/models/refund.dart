import 'package:projet_picsou/models/User.dart';
import 'package:projet_picsou/models/payment.dart';

import '../enums/refundStatusEnum.dart';

class Refund extends Payment {

  final RefundStatusEnum status;
  final User from;
  final User to;

  Refund(super.id, super.date, super.amount, this.from, this.to, {this.status = RefundStatusEnum.waiting});

}