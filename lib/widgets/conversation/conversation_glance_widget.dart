
import 'package:flutter/material.dart';
import 'package:projet_picsou/core/theme/app_theme.dart';
import 'package:projet_picsou/models/friend.dart';

import '../../controllers/user_controller.dart';
import '../payment/last_five_payments_widget.dart';

class ConversationGlanceWidget extends StatelessWidget {

  final Friend friend;
  final UserController userController = UserController();
  final Function closeFunction;

  ConversationGlanceWidget({required this.friend, required this.closeFunction, super.key});

  @override
  Widget build(BuildContext context) {

    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(40),
          topRight: Radius.circular(40),
        ),
        color: darkColor,
      ),


      child: SingleChildScrollView(
        child: Column(
            children: [


              Container(
                padding: EdgeInsets.all(20),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    CloseButton(
                      color: darkColor,
                      style: ButtonStyle(
                        backgroundColor: WidgetStateProperty.all(primaryColor),
                        padding: WidgetStateProperty.all(EdgeInsets.all(10)),
                        shape: WidgetStateProperty.all(RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(100),
                        )),
                      ),
                      onPressed: () {
                        closeFunction();
                      },
                    )
                  ],
                ),
              ),


              Center(
                child: Column(
                    children: [

                      Container(
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(100),
                        ),
                        clipBehavior: Clip.antiAlias,
                        width: 130,
                        height: 130,
                        child: Image.network(
                          friend.profilPicture,
                          fit: BoxFit.cover,
                          loadingBuilder: (context, child, loadingProgress) {
                            if (loadingProgress == null) {
                              return child;
                            }
                            return const Center(child: CircularProgressIndicator());
                          },
                          errorBuilder: (context, error, stackTrace) {
                            return const Icon(Icons.error, size: 30, color: Colors.red);
                          },
                        ),
                      ),

                      SizedBox(height: 10),

                      Text(
                          textAlign: TextAlign.center,
                          style: TextStyle(
                              fontSize: 20
                          ),
                          '${friend.name} ${friend.surname}'
                      ),

                      SizedBox(height: 10),

                      SizedBox(
                        width: 150,
                        child: TextButton(
                            style: ButtonStyle(
                                foregroundColor: WidgetStateProperty.all(backgroundColor),
                                backgroundColor: WidgetStateProperty.all(primaryColor),
                                shape: WidgetStateProperty.all(RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(100),
                                )),
                                textStyle: WidgetStateProperty.all(TextStyle(
                                  fontWeight: FontWeight.normal,
                                ))
                            ),
                            onPressed: (){print('test');},
                            child: Row(
                                mainAxisAlignment: MainAxisAlignment.spaceAround,
                                children: [
                                  Text("Voir le profil"),
                                  Icon(Icons.arrow_forward)
                                ]
                            )
                        ),
                      ),

                      SizedBox(height: 20),

                      Center(
                        child: Text(
                            textAlign: TextAlign.center,
                            style: TextStyle(
                                fontSize: 30,
                                fontWeight: FontWeight.w900
                            ),
                            friend.balance > 0 ?
                            '${friend.name} vous doit de l\'argent ! 🎉' :
                            'Zut, vous devez de l\'argent à ${friend.name}... 😭'
                        ),
                      ),

                      SizedBox(height: 20),

                      Column(
                          children: [
                            Text("votre balance :"),
                            SizedBox(height: 10),
                            Container(
                              padding: EdgeInsets.fromLTRB(30, 10, 30, 10),
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(20),
                                gradient: LinearGradient(
                                  colors: [primaryColor, primaryDarkColor],
                                  begin: Alignment.topCenter,
                                  end: Alignment.bottomCenter,
                                ),
                              ),
                              clipBehavior: Clip.antiAlias,
                              child: Text(
                                  textAlign: TextAlign.center,
                                  style: TextStyle(
                                      fontSize: 50,
                                      fontWeight: FontWeight.w900
                                  ),
                                  '${friend.balance.toString()} €'
                              ),
                            )
                          ]
                      ),

                      SizedBox(height: 20),

                      LastFivePaymentWidget(friendId: friend.id)
                    ]
                ),
              )
            ]
        ),
      )
    );
  }
}