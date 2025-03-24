import 'package:flutter/cupertino.dart';
import 'conversation_button.dart';

class ConversationButtonList extends StatelessWidget {

  final List<ConversationButton> conversationsButtons;

  const ConversationButtonList(this.conversationsButtons, {super.key});

  @override
  Widget build(BuildContext context) {
    return ListView(
      shrinkWrap: true,
      children: conversationsButtons,
    );
  }
}