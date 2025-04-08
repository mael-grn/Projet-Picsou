import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';
import '../../core/theme/app_theme.dart';
import '../../models/friend.dart';

/// Widget intended to be used in a list, to open a conversation
class ConversationButtonWidget extends StatelessWidget {

  final Friend friend;
  final VoidCallback onPressed;

  const ConversationButtonWidget(this.friend, {super.key, required this.onPressed});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        SizedBox(height: 5),
        TextButton(

            onPressed: onPressed,
            child: Container(
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Container(
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(100),
                      ),
                      clipBehavior: Clip.antiAlias,
                      width: 60,
                      height: 60,
                      child: Image.network(
                        friend.profilPictureRef,
                        fit: BoxFit.cover,
                        loadingBuilder: (context, child, loadingProgress) {
                        if (loadingProgress == null) {
                        return child;
                        }
                        return Shimmer.fromColors(
                            baseColor: backgroundVariantColor,
                            highlightColor: secondaryColor,
                            child: Container(
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(100),
                                color: backgroundVariantColor,
                              ),
                              clipBehavior: Clip.antiAlias,
                              width: 60,
                              height: 60,
                            )
                        );
                        },
                        errorBuilder: (context, error, stackTrace) {
                          return const Icon(Icons.error, size: 30, color: Colors.red);
                        },
                      ),
                    ),
                    SizedBox(width: 20),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          textAlign: TextAlign.left,
                          style: TextStyle(
                            fontWeight: FontWeight.w900,
                            fontSize: 18
                          ),
                            '${friend.firstName} ${friend.lastName}'
                        ),
                        SizedBox(height: 3),
                        Text(
                            textAlign: TextAlign.left,
                          style: TextStyle(
                            fontSize: 12,
                          ),
                            (friend.balance < 0 ? 'Vous devez : ${friend.balance} €' : 'Vous doit : ${friend.balance.toString().replaceAll("-", "")} €')
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