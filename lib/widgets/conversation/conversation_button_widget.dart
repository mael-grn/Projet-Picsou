import 'package:flutter/material.dart';
import 'package:projet_picsou/core/theme/app_theme.dart';
import 'package:projet_picsou/models/group.dart';
import '../../models/friend.dart';
import 'package:shimmer/shimmer.dart';

/// Widget intended to be used in a list, to open a conversation
class ConversationButtonWidget extends StatelessWidget {

  final Group group;
  final VoidCallback onPressed;
  final String nom; // Main name of the widget
  final String? sousTitre; // subtitle of the main name
  final String? subject; // Value or information at the right of the widget
  final Color subjetcColor;

  const ConversationButtonWidget({required this.nom, this.sousTitre, this.subject, super.key, required this.onPressed, required this.group, this.subjetcColor = Colors.black});

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
                        group.profilPicture,
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
                            nom
                        ),
                        SizedBox(height: 3),
                        Text(
                            textAlign: TextAlign.left,
                          style: TextStyle(
                            fontSize: 12,
                          ),
                            sousTitre ?? ""
                        )
                      ],
                    ),
                    SizedBox(width:200),
                    Text(
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        fontWeight: FontWeight.w700,
                        fontSize: 18,
                        color: subjetcColor
                      ),
                      subject ?? ""
                    )
                  ],
                )
            )
        )
      ],
    ) ;
  }
}