import 'package:flutter/material.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';
import 'package:projet_picsou/core/theme/app_theme.dart';
import 'package:projet_picsou/models/friend.dart';

import '../controllers/payment_controller.dart';
import '../models/expense.dart';
import '../models/payment.dart';
import '../models/refund.dart';
import '../widgets/payment/expense_widget.dart';
import '../widgets/payment/refund_widget.dart';

class FriendConversationView extends StatefulWidget {
  final Friend friend;

  const FriendConversationView({required this.friend, super.key});

  @override
  _friendConversationViewState createState() => _friendConversationViewState();
}

class _friendConversationViewState extends State<FriendConversationView>
    with TickerProviderStateMixin {
  final PaymentController paymentController = PaymentController();
  late AnimationController _globalController;
  late Animation<Offset> _globalOffsetAnimation;

  @override
  void initState() {
    super.initState();
    _globalController = AnimationController(
      duration: const Duration(milliseconds: 500), // Durée de l'animation
      vsync: this,
    );

    _globalOffsetAnimation = Tween<Offset>(
      begin: Offset(0.0, 2.0), // Commence en bas de l'écran
      end: Offset.zero, // Termine à sa position normale
    ).animate(
      CurvedAnimation(
        parent: _globalController,
        curve: Curves.easeOut, // Type d'animation
      ),
    );

    _globalController.forward();
  }

  @override
  void dispose() {
    _globalController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        scrolledUnderElevation: 0,
        backgroundColor: backgroundColor,
        title: Row(
          children: [
            CircleAvatar(
              backgroundImage: NetworkImage(widget.friend.profilPicture),
            ),
            SizedBox(width: 10),
            Text("${widget.friend.name} ${widget.friend.surname}"),
          ],
        ),
      ),

      body: Stack(
        children: [

          Container(
            color: backgroundColor,
            padding: EdgeInsets.fromLTRB(0, 10, 0, 0),
            child: SlideTransition(
              position: _globalOffsetAnimation,
              child: Container(
                padding: EdgeInsets.all(20),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(40),
                    topRight: Radius.circular(40),
                  ),
                  color: backgroundColor,
                ),
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
                          "${widget.friend.balance} €",
                        ),
                      ],
                    ),

                    FutureBuilder(
                      future: paymentController.getLastPaymentFromFriend(widget.friend.id),
                      builder: (context, snapshot) {
                        if (snapshot.connectionState == ConnectionState.waiting) {
                          return Expanded(
                            child: Center(
                              child: LoadingAnimationWidget.inkDrop(
                                color: Colors.white,
                                size: 30,
                              ),
                            ),
                          );
                        } else if (snapshot.hasData) {
                          List<Payment> payments = snapshot.data!;

                          return Expanded(
                            child: Padding(
                              padding: EdgeInsets.fromLTRB(0, 30, 0, 0),
                              child: ListView.builder(
                                padding: EdgeInsets.fromLTRB(0, 0, 0, 100),
                                shrinkWrap: true,  // Évite l'overflow
                                itemCount: payments.length,
                                itemBuilder: (context, index) {
                                  Payment payment = payments[index];

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
                          );
                        } else {
                          return Expanded(
                            child: Center(child: Text("Erreur")),
                          );
                        }
                      },
                    ),
                  ],
                ),
              ),
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
                  backgroundColor: WidgetStateProperty.all(foregroundVariantColor),
                  shape: WidgetStateProperty.all(
                    RoundedRectangleBorder(borderRadius: BorderRadius.circular(100)),
                  ),
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      textAlign: TextAlign.center,
                      style: TextStyle(fontWeight: FontWeight.normal, fontSize: 20),
                      "Ajouter une dépense",
                    ),
                    SizedBox(width: 10),
                    Icon(Icons.add, size: 20),
                  ],
                ),
              ),
            ),
          ),

        ]

      )
    );
  }
}
