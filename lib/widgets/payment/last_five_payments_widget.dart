import 'package:flutter/material.dart';
import 'package:projet_picsou/controllers/payment_controller.dart';
import 'package:projet_picsou/models/expense.dart';
import 'package:projet_picsou/widgets/payment/expense_widget.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';
import '../../core/theme/app_theme.dart';
import '../../models/payment.dart';

/// Widget to display the last five payments with a friend.
/// It recognize the type of payment and display it accordingly.
class LastFivePaymentWidget extends StatelessWidget {
  final PaymentController paymentController = PaymentController();
  final int friendId;

  LastFivePaymentWidget({required this.friendId, super.key});

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: paymentController.getFiveLastPaymentFromFriend(friendId),
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
                size: 200,
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
                          return ExpenseWidget(payment as Expense);
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
                        print('test');
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
