import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:projet_picsou/core/theme/app_theme.dart';

class ConversationButton extends StatelessWidget {

  final String name;
  final IconData icon;
  final String surname;
  final double balance;

  const ConversationButton(this.icon, this.name, this.surname, this.balance, {super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        SizedBox(height: 10),
        ElevatedButton(
            style: ElevatedButton.styleFrom(
              backgroundColor: customColor[50],
              foregroundColor: Colors.black,
              elevation: 0,
              minimumSize: Size(double.infinity, 80)
            ),
            onPressed: () { print('Button $name pressed'); },
            child: Container(
                child: Row(
                  children: [
                    Container(
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(100),
                        color: customColor[100],
                      ),
                      padding: EdgeInsets.all(15),
                      child: Icon(icon),
                    ),
                    SizedBox(width: 10),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          textAlign: TextAlign.left,
                          style: TextStyle(

                            fontWeight: FontWeight.w900,
                            fontSize: 16
                          ),
                            '$name $surname'
                        ),
                        Text(
                            textAlign: TextAlign.left,
                          style: TextStyle(
                            fontSize: 12
                          ),
                            (balance > 0 ? 'Vous devez : $balance €' : 'Vous doit : $balance €')
                        )
                      ],
                    ),
                  ],
                )
            )
        )
      ],
    ) ;
  }
}