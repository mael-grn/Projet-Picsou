import 'package:flutter/material.dart';
import 'package:projet_picsou/core/theme/app_theme.dart';
import 'package:projet_picsou/models/friend.dart';
import 'package:projet_picsou/models/group.dart';
import 'package:projet_picsou/widgets/conversation/conversation_button_list_widget.dart';
import 'package:projet_picsou/widgets/finance/balance_detail_widget.dart';
import '../widgets/conversation/conversation_glance_widget.dart';
import '../widgets/finance/balance_widget.dart';
import 'package:vibration/vibration.dart';

class HomeView extends StatefulWidget {
  const HomeView({super.key});

  @override
  _HomeViewState createState() => _HomeViewState();
}

class _HomeViewState extends State<HomeView> with TickerProviderStateMixin {

  bool _isConversationGlanceVisible = false;
  bool _isBalanceDetailsVisible = false;
  Group? _conversationGlanceGroup;
  late AnimationController _globalController;
  late AnimationController _glanceController;
  late Animation<Offset> _globalOffsetAnimation;
  late Animation<Offset> _glanceOffsetAnimation;
  late AnimationController _balanceController;
late Animation<Offset> _balanceOffsetAnimation;


  void _toggleConversationGlance(Group group) {

    Vibration.hasVibrator().then((hasVibrator) {
      if (hasVibrator) {
        Vibration.vibrate(duration: 1);
      }
    });

    setState(() {
      _conversationGlanceGroup = group;
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
        _conversationGlanceGroup = null;
      });
    });
  }

void _toggleBalanceDetail(){
  print("test de toggle balance");
  setState(() {
    _isBalanceDetailsVisible = true;
  });
  _balanceController.forward();
}

void _closeBalanceDetail() {
  _balanceController.reverse().then((_) {
    setState(() {
      _isBalanceDetailsVisible = false;
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

    _balanceController = AnimationController(
      duration: const Duration(milliseconds: 300),
      vsync: this,
    );

    _balanceOffsetAnimation = Tween<Offset>(
      begin: Offset(0.0, 1.0),
      end: Offset.zero,
    ).animate(CurvedAnimation(
      parent: _balanceController,
      curve: Curves.easeOut,
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
                            GestureDetector(
                              onTap: _toggleBalanceDetail,
                              child: Container(
                                padding: EdgeInsets.fromLTRB(15, 20, 15, 20),
                                child: BalanceWidget(),
                                
                              ),
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
        if (_isConversationGlanceVisible && _conversationGlanceGroup != null)
          Positioned(
            top: 0,
            left: 0,
            right: 0,
            bottom: 0,
            child: SlideTransition(
              position: _glanceOffsetAnimation,
              child: ConversationGlanceWidget(group: _conversationGlanceGroup!, closeFunction: _closeConversationGlance)
            )
          ),

        if (_isBalanceDetailsVisible)
          Positioned(
            top: 0,
            left: 0,
            right: 0,
            bottom: 0,
            child: SlideTransition(
              position: _balanceOffsetAnimation, // Utilisation du bon contrôleur
              child: BalanceDetailWidget(closeFunction: _closeBalanceDetail),
            ),
          ),
      ],
    );
  }
}