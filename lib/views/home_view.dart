import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:projet_picsou/core/theme/app_theme.dart';
import 'package:projet_picsou/models/friend.dart';
import 'package:projet_picsou/widgets/conversation/conversation_button_list_widget.dart';
import '../widgets/conversation/conversation_glance_widget.dart';
import '../widgets/finance/balance_widget.dart';

class HomeView extends StatefulWidget {
  const HomeView({super.key});

  @override
  _HomeViewState createState() => _HomeViewState();
}

class _HomeViewState extends State<HomeView> with TickerProviderStateMixin {

  bool _isConversationGlanceVisible = false;
  Friend? _conversationGlanceFriend;
  late AnimationController _globalController;
  late AnimationController _glanceController;
  late Animation<Offset> _globalOffsetAnimation;
  late Animation<Offset> _glanceOffsetAnimation;


  void _toggleConversationGlance(Friend friend) {

    HapticFeedback.selectionClick();
    setState(() {
      _conversationGlanceFriend = friend;
      _isConversationGlanceVisible = true;
    });

    _glanceController.forward();
  }

  void _closeConversationGlance() {
    _glanceController.reverse().then((value) {
      setState(() {
        _isConversationGlanceVisible = false;
        _conversationGlanceFriend = null;
      });
    });
  }

  @override
  void initState() {
    super.initState();
    _globalController = AnimationController(
      duration: const Duration(milliseconds: 300), // Durée de l'animation
      vsync: this,
    );

    _glanceController = AnimationController(
      duration: const Duration(milliseconds: 300), // Durée de l'animation
      vsync: this,
    );

    _globalOffsetAnimation = Tween<Offset>(
      begin: Offset(0.0, 2.0), // Commence en bas de l'écran
      end: Offset.zero, // Termine à sa position normale
    ).animate(CurvedAnimation(
      parent: _globalController,
      curve: Curves.easeOut, // Type d'animation
    ));

    _glanceOffsetAnimation = Tween<Offset>(
      begin: Offset(0.0, 1.0), // Commence en bas de l'écran
      end: Offset.zero, // Termine à sa position normale
    ).animate(CurvedAnimation(
      parent: _glanceController,
      curve: Curves.easeOut, // Type d'animation
    ));

    _globalController.forward();
  }

  @override
  void dispose() {
    _globalController.dispose();
    _glanceController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Container(
            color: primaryColor,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [


                Padding(
                  padding: EdgeInsets.fromLTRB(15, 75, 15, 20),
                  child: Row(
                    children: [
                      Text(
                          'Bonjour, Maël',
                          textAlign: TextAlign.start,
                          style: TextStyle(
                            color: backgroundColor,
                            fontWeight: FontWeight.w600,
                            fontSize: 35,
                          )
                      ),
                    ],
                  ),
                ),


                Expanded(
                    child: SlideTransition(
                      position: _globalOffsetAnimation,
                      child: Container(
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.only(
                            topLeft: Radius.circular(40),
                            topRight: Radius.circular(40),
                          ),
                          color: backgroundVariantColor,
                        ),
                        child: Column(
                          children: [


                            Container(
                              padding: EdgeInsets.fromLTRB(15, 20, 15, 20),
                              child: BalanceWidget(),
                            ),

                            ConversationButtonListWidget(
                              onConversationButtonPressed: _toggleConversationGlance,
                            ),

                          ],
                        ),
                      ),
                    )
                )

              ],
            )
        ),
        if (_isConversationGlanceVisible && _conversationGlanceFriend != null)

          Positioned(
            top: 0,
            left: 0,
            right: 0,
            bottom: 0,
            child: SlideTransition(
              position: _glanceOffsetAnimation,
              child: ConversationGlanceWidget(friend: _conversationGlanceFriend!, closeFunction: _closeConversationGlance)
            )
          ),
      ],
    );
  }
}