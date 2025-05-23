import 'package:flutter/material.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';
import 'package:projet_picsou/controllers/friend_conversation_controller.dart';
import 'package:projet_picsou/core/theme/app_theme.dart';
import 'package:provider/provider.dart';
import '../models/expense.dart';
import '../models/payment.dart';
import '../models/refund.dart';
import '../models/user.dart';
import '../widgets/payment/expense_widget.dart';
import '../widgets/payment/refund_widget.dart';

class FriendConversationView extends StatefulWidget {
  final User friend;
  const FriendConversationView({required this.friend, super.key});

  @override
  State<FriendConversationView> createState() => _FriendConversationViewState();
}

class _FriendConversationViewState extends State<FriendConversationView> {

  @override
  Widget build(BuildContext context) {
    final controller = context.watch<FriendConversationController>();
    return Scaffold(
      appBar: AppBar(
        scrolledUnderElevation: 0,
        backgroundColor: backgroundColor,
        title: Row(
          children: [
            CircleAvatar(
              backgroundImage: NetworkImage(widget.friend.profilPictureRef),
            ),
            SizedBox(width: 10),
            Text("${widget.friend.firstName} ${widget.friend.lastName}"),
          ],
        ),
      ),
      body: Stack(
        children: [
          Container(
            decoration: BoxDecoration(color: backgroundColor),
            padding: EdgeInsets.fromLTRB(20, 0, 20, 0),
            child: Column(
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text("Votre balance actuelle : "),
                    SizedBox(width: 10),
                    Text(
                      style: TextStyle(
                        fontWeight: FontWeight.w900,
                        fontSize: 25,
                      ),
                      "${controller.friendBalance} €",
                    ),
                  ],
                ),

                if (controller.isLoading)
                  Expanded(
                    child: Center(
                      child: LoadingAnimationWidget.inkDrop(
                        color: foregroundColor,
                        size: 30,
                      ),
                    ),
                  )
                else if (controller.error != null)
                  Expanded(
                    child: Center(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Icon(size: 40, Icons.error_outline),
                          SizedBox(height: 10),
                          Text(controller.error!),
                        ],
                      ),
                    ),
                  )
                else
                  Expanded(
                    child: Padding(
                      padding: EdgeInsets.fromLTRB(0, 30, 0, 0),
                      child: ListView.builder(
                        padding: EdgeInsets.fromLTRB(0, 0, 0, 100),
                        shrinkWrap: true,
                        itemCount: controller.payments.length,
                        itemBuilder: (context, index) {
                          Payment payment = controller.payments[index];

                          if (payment is Expense) {
                            return ExpenseWidget(payment);
                          } else if (payment is Refund) {
                            return RefundWidget(payment);
                          } else {
                            return Container();
                          }
                        },
                      ),
                    ),
                  ),
              ],
            ),
          ),
          Positioned(
            bottom: 0,
            left: 0,
            right: 0,
            child: Container(
              decoration: const BoxDecoration(
                gradient: LinearGradient(
                  end: Alignment.topCenter,
                  begin: Alignment.bottomCenter,
                  colors: [Colors.black, Colors.transparent],
                ),
              ),
              padding: EdgeInsets.fromLTRB(20, 0, 20, 50),
              child: TextButton(
                onPressed: () {},
                style: ButtonStyle(
                  foregroundColor: WidgetStateProperty.all(backgroundColor),
                  backgroundColor: WidgetStateProperty.all(
                    foregroundVariantColor,
                  ),
                  shape: WidgetStateProperty.all(
                    RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(100),
                    ),
                  ),
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        fontWeight: FontWeight.normal,
                        fontSize: 20,
                      ),
                      "Ajouter une dépense",
                    ),
                    SizedBox(width: 10),
                    Icon(Icons.add, size: 20),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
