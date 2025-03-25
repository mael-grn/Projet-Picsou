import 'package:flutter/material.dart';
import 'package:projet_picsou/core/theme/app_theme.dart';
import 'package:projet_picsou/widgets/conversation/conversation_button_list.dart';
import '../widgets/finance/balance.dart';

class HomePage extends StatelessWidget {
  HomePage({super.key});

  @override
  Widget build(BuildContext context) {

    return Container(
            color: customColor[200],
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [


                Padding(
                    padding: EdgeInsets.fromLTRB(15, 100, 15, 20),
                  child: Row(
                    children: [
                      Text(
                        'Bonjour, Maël',
                        textAlign: TextAlign.start,
                        style: TextStyle(
                            fontWeight: FontWeight.w800,
                            fontSize: 25
                        )
                      ),
                    ],
                  ),
                ),


                Expanded(
                    child: Container(
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.only(
                          topLeft: Radius.circular(20),
                          topRight: Radius.circular(20),
                        ),
                        color: customColor[100],
                      ),
                      child: Column(
                        children: [


                          Container(
                            padding: EdgeInsets.fromLTRB(15, 20, 15, 20),
                            child: Balance(),
                          ),


                          Expanded(
                              child: Container(
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.only(
                                    topLeft: Radius.circular(20),
                                    topRight: Radius.circular(20),
                                  ),
                                  color: customColor[50],
                                ),
                                padding: EdgeInsets.fromLTRB(20, 0, 20, 0),
                                child: ConversationButtonList(),
                              )
                          )


                        ],
                      ),
                    )
                )

              ],
            )
        );
  }
}