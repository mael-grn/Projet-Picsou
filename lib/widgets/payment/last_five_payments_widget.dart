import 'package:flutter/material.dart';
import 'package:projet_picsou/controllers/payment_controller.dart';
import 'package:projet_picsou/models/expense.dart';
import 'package:projet_picsou/views/friend_conversation_view.dart';
import 'package:projet_picsou/widgets/payment/expense_widget.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';
import 'package:projet_picsou/widgets/payment/refund_widget.dart';
import '../../core/theme/app_theme.dart';
import '../../models/friend.dart';
import '../../models/payment.dart';
import '../../models/refund.dart';

/// Widget to display the last five payments with a friend.
/// It recognize the type of payment and display it accordingly.
class LastFivePaymentWidget extends StatelessWidget {
  final PaymentController paymentController = PaymentController();
  final Friend friend;

  LastFivePaymentWidget({required this.friend, super.key});

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: paymentController.getFiveLastPaymentFromFriend(friend.id),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return Container(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.all(Radius.circular(20)),
              color: darkColor,
            ),
            padding: EdgeInsets.all(10),
            child: Center(
              child: LoadingAnimationWidget.inkDrop(
                color: Colors.white,
                size: 30,
              ),
            ),
          );
        } else if (snapshot.hasData) {
          List<Payment> payments = snapshot.data!;
          return Container(
            padding: EdgeInsets.all(20),
            child: Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.all(Radius.circular(20)),
                color: primaryDarkColor,
              ),
              padding: EdgeInsets.all(10),
              child: Column(
                children: [
                  Column(
                    children:
                        payments.map((payment) {
                          switch (payment.runtimeType) {
                            case Expense:
                              return ExpenseWidget(payment as Expense);
                            case Refund:
                              return RefundWidget(payment as Refund);
                            default:
                              return Container();
                          }
                        }).toList(),
                  ),
                  SizedBox(
                    width: 220,
                    child: TextButton(
                      style: ButtonStyle(
                        foregroundColor: WidgetStateProperty.all(
                          backgroundColor,
                        ),
                        backgroundColor: WidgetStateProperty.all(primaryColor),
                        shape: WidgetStateProperty.all(
                          RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(100),
                          ),
                        ),
                        textStyle: WidgetStateProperty.all(
                          TextStyle(fontWeight: FontWeight.normal),
                        ),
                      ),
                      onPressed: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => FriendConversationView(friend: friend),
                          ),
                        );
                      },
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        children: [
                          Text("Voir tous les paiements"),
                          Icon(Icons.arrow_forward),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
          );
        } else {
          return Text("Erreur");
        }
      },
    );
  }
}
