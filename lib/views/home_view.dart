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

class _HomeViewState extends State<HomeView>
    with TickerProviderStateMixin, AutomaticKeepAliveClientMixin {
  bool _isConversationGlanceVisible = false;
  Friend? _conversationGlanceFriend;

  late AnimationController _globalController;
  late AnimationController _glanceController;

  late Animation<Offset> _balanceOffsetAnimation;
  late Animation<Offset> _conversationListOffsetAnimation;
  late Animation<Offset> _glanceOffsetAnimation;

  void _toggleConversationGlance(Friend friend) {
    HapticFeedback.selectionClick();
    _glanceController.forward();

    setState(() {
      _conversationGlanceFriend = friend;
      _isConversationGlanceVisible = true;
    });
  }

  void _closeConversationGlance() {
    _glanceController.reverse().then((_) {
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
      duration: const Duration(milliseconds: 600),
      vsync: this,
    );

    _glanceController = AnimationController(
      duration: const Duration(milliseconds: 600),
      vsync: this,
    );

    _balanceOffsetAnimation = Tween<Offset>(
      begin: const Offset(0.0, 0.8),
      end: Offset.zero,
    ).animate(CurvedAnimation(
      parent: _globalController,
      curve: Curves.easeOutCubic,
    ));

    _conversationListOffsetAnimation = Tween<Offset>(
      begin: const Offset(0.0, 1.0),
      end: Offset.zero,
    ).animate(CurvedAnimation(
      parent: _globalController,
      curve: Curves.easeOutCubic,
    ));

    _glanceOffsetAnimation = Tween<Offset>(
      begin: const Offset(0.0, 1.0),
      end: Offset.zero,
    ).animate(CurvedAnimation(
      parent: _glanceController,
      curve: Curves.decelerate,
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
    super.build(context); // Nécessaire pour AutomaticKeepAliveClientMixin

    return Stack(
      children: [
        Container(
          color: primaryColor,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Row(
                children: [
                  const Padding(
                    padding: EdgeInsets.fromLTRB(15, 75, 15, 20),
                    child: Text(
                      'Bonjour, Maël',
                      textAlign: TextAlign.start,
                      style: TextStyle(
                        fontWeight: FontWeight.w600,
                        fontSize: 35,
                      ),
                    ),
                  ),
                ],
              ),
              Expanded(
                child: SlideTransition(
                  position: _balanceOffsetAnimation,
                  child:  Container(
                      decoration: BoxDecoration(
                        borderRadius: const BorderRadius.only(
                          topLeft: Radius.circular(40),
                          topRight: Radius.circular(40),
                        ),
                        color: backgroundVariantColor,
                      ),
                      child: Column(
                        children: [
                          Padding(
                              padding: EdgeInsets.fromLTRB(15, 20, 15, 20),
                              child:  BalanceWidget()
                          ),
                          Expanded(
                            child: SlideTransition(
                              position: _conversationListOffsetAnimation,
                              child: ConversationButtonListWidget(
                                onConversationButtonPressed:
                                _toggleConversationGlance,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),

            ],
          ),
        ),
        if (_isConversationGlanceVisible && _conversationGlanceFriend != null)
          Positioned.fill(
            child: SlideTransition(
              position: _glanceOffsetAnimation,
              child: ConversationGlanceWidget(
                friend: _conversationGlanceFriend!,
                closeFunction: _closeConversationGlance,
              ),
            ),
          ),
      ],
    );
  }

  @override
  bool get wantKeepAlive => true;
}
