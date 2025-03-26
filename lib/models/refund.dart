import 'package:projet_picsou/models/user.dart';
import 'package:projet_picsou/models/payment.dart';

import '../enums/refund_status_enum.dart';

class Refund extends Payment {

  final RefundStatusEnum status;
  final User from;
  final User to;

  Refund(super.id, super.date, super.amount, this.from, this.to, {this.status = RefundStatusEnum.waiting});

}