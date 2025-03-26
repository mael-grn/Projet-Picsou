import 'package:flutter/material.dart';
import 'package:projet_picsou/core/theme/app_theme.dart';
import 'package:projet_picsou/models/Friend.dart';
import 'package:projet_picsou/widgets/conversation/conversation_button_list.dart';
import '../widgets/conversation/conversation_glance.dart';
import '../widgets/finance/balance.dart';
import 'package:vibration/vibration.dart';

class HomePage extends StatefulWidget {
  HomePage({super.key});

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> with TickerProviderStateMixin {

  bool _isConversationGlanceVisible = false;
  Friend? _conversationGlanceFriend;
  late AnimationController _globalController;
  late AnimationController _glanceController;
  late Animation<Offset> _globalOffsetAnimation;
  late Animation<Offset> _glanceOffsetAnimation;


  void _toggleConversationGlance(Friend friend) {

    Vibration.hasVibrator().then((hasVibrator) {
      if (hasVibrator) {
        Vibration.vibrate(duration: 1);
      }
    });

    setState(() {
      _conversationGlanceFriend = friend;
      _isConversationGlanceVisible = true;
    });
    _globalController.reverse();
    _glanceController.forward();
  }

  void _closeConversationGlance() {
    _glanceController.reverse().then((value) {
      _globalController.forward();
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
      begin: Offset(0.0, 1.0), // Commence en bas de l'écran
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
                  padding: EdgeInsets.fromLTRB(15, 20, 15, 20),
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
                          color: primaryDarkColor,
                        ),
                        child: Column(
                          children: [


                            Container(
                              padding: EdgeInsets.fromLTRB(15, 20, 15, 20),
                              child: Balance(),
                            ),


                            ConversationButtonList(
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
              child: ConversationGlance(friend: _conversationGlanceFriend!, closeFunction: _closeConversationGlance)
            )
          ),
      ],
    );
  }
}