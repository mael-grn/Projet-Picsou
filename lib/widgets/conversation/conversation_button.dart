import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:projet_picsou/core/theme/app_theme.dart';

import '../../models/Friend.dart';

class ConversationButton extends StatelessWidget {

  final Friend friend;

  const ConversationButton(this.friend, {super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        SizedBox(height: 5),
        ElevatedButton(
            style: ElevatedButton.styleFrom(
              backgroundColor: customColor[50],
              foregroundColor: Colors.black,
              elevation: 0,
              minimumSize: Size(double.infinity, 80)
            ),
            onPressed: () { print('Button ${friend.name} pressed'); },
            child: Container(
                child: Row(
                  children: [
                    Container(
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(100),
                      ),
                      clipBehavior: Clip.antiAlias,
                      width: 60,
                      height: 60,
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
                          print(friend.profilPicture);
                          return const Icon(Icons.error, size: 30, color: Colors.red);
                        },
                      ),
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
                            '${friend.name} ${friend.surname}'
                        ),
                        Text(
                            textAlign: TextAlign.left,
                          style: TextStyle(
                            fontSize: 12
                          ),
                            (friend.balance > 0 ? 'Vous devez : ${friend.balance} €' : 'Vous doit : ${friend.balance} €')
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