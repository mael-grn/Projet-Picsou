import 'package:flutter/material.dart';
import 'package:projet_picsou/core/theme/app_theme.dart';
import '../widgets/conversation/conversation_button.dart';
import '../widgets/conversation/conversation_button_list.dart';

class HomePage extends StatelessWidget {
  HomePage({super.key});
  final List<ConversationButton> convButtons = List.from([
    ConversationButton(Icons.person, 'Julien Becheras'),
    ConversationButton(Icons.person, 'Maël Garnier'),
  ]);
  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
        child: Container(
            color: customColor[200],
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Padding(
                    padding: EdgeInsets.fromLTRB(15, 20, 15, 20),
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

                Container(
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
                        child: Text(
                            style: TextStyle(
                                fontWeight: FontWeight.w900,
                                fontSize: 30
                            ),
                            '+ 89,09 €'
                        ),
                      ),
                      Container(
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.only(
                              topLeft: Radius.circular(20),
                              topRight: Radius.circular(20),
                            ),
                            color: customColor[50],

                          ),
                          padding: EdgeInsets.fromLTRB(0, 0, 0, 0),
                          child: ConversationButtonList(convButtons)
                      )
                    ],
                  ),
                )
              ],
            )
        )
    );
  }
}