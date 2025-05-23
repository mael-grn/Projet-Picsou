import 'package:projet_picsou/models/refund.dart';

import '../core/provider.dart';

class RefundService {
  Future<Refund> createExpense(Refund refund) async {
    final response = await Provider.postSecure('/refunds', refund.toJson());
    return Refund.fromJson(response['refund']);
  }

  Future<Refund> getExpenseFromId(int refundId) async {
    final response = await Provider.getSecure('/refunds/$refundId');
    return Refund.fromJson(response['expense_evo']);
  }

  Future<void> updateExpense(Refund refund) async {
    await Provider.putSecure('/refunds/${refund.id}', refund.toJson());
  }

  Future<void> deleteExpense(int refundId) async {
    await Provider.deleteSecure('/refunds/$refundId', {});
  }
}