import 'package:flutter/material.dart';
import 'package:projet_picsou/core/theme/app_theme.dart';

import '../widgets/conversation/conversation_button.dart';
import '../widgets/conversation/conversation_button_list.dart';

class Demo extends StatelessWidget {

    Demo({super.key});

    final List<ConversationButton> convButtons = List.from([
    ConversationButton(Icons.person, 'Julien Becheras'),
    ConversationButton(Icons.person, 'Maël Garnier'),
  ]);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text("Picsou"),
          actions: [
            IconButton(
              icon: Icon(Icons.search),
              onPressed: () {
                print("RECHERCHER");
              },
            ),
          ],
          backgroundColor: customColor[200], // optionnel : adapter la couleur
          elevation: 0, // optionnel : enlever l’ombre
        ),
      body: SingleChildScrollView(
        child: Container(
          color: customColor[200],
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Row(
                  children: [
                    Padding(
                      padding: EdgeInsets.fromLTRB(15, 20, 15, 20),
                      child: Text(
                          'Bonjour, Maël',
                          textAlign: TextAlign.start,
                          style: TextStyle(
                              fontWeight: FontWeight.w800,
                              fontSize: 25
                          )

                      ),
                    )
                  ],
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
      )
    );

  }
}