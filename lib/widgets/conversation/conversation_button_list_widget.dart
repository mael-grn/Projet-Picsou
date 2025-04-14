import 'package:flutter/material.dart';
import 'package:projet_picsou/controllers/conversation_list_controller.dart';
import 'package:provider/provider.dart';
import '../../core/theme/app_theme.dart';
import 'conversation_button_loading_widget.dart';
import 'conversation_button_widget.dart';

class ConversationButtonListWidget extends StatefulWidget {
  const ConversationButtonListWidget({super.key});

  @override
  State<ConversationButtonListWidget> createState() =>
      _ConversationButtonListWidgetState();
}

/// Widget to display a list of conversations, using the ConversationButtonWidget.
class _ConversationButtonListWidgetState
    extends State<ConversationButtonListWidget> {
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      final entryPointController = Provider.of<ConversationListController>(
        context,
        listen: false,
      );
      entryPointController.getAllGroups();
    });
  }

  @override
  Widget build(BuildContext context) {
    final conversationListController =
        context.watch<ConversationListController>();

    return Container(
      padding: EdgeInsets.fromLTRB(10, 20, 10, 20),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(40),
          topRight: Radius.circular(40),
        ),
        color: backgroundColor,
      ),
      child: ListView(
        padding: EdgeInsets.zero,
        children: [
          if (conversationListController.isLoading)
            ConversationButtonLoadingWidget()
          else if (conversationListController.error != null)
            Padding(
              padding: EdgeInsets.fromLTRB(30, 0, 30, 0),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  SizedBox(height: 30),
                  Icon(size: 40, Icons.error_outline),
                  SizedBox(height: 10),
                  Text(
                    textAlign: TextAlign.center,
                    conversationListController.error!,
                  ),
                ],
              ),
            )
          else if (conversationListController.groups.isEmpty)
              Padding(
                padding: EdgeInsets.fromLTRB(30, 0, 30, 0),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    SizedBox(height: 30),
                    Icon(size: 40, Icons.info_outline),
                    SizedBox(height: 10),
                    Text(
                      textAlign: TextAlign.center,
                      "Vous n'avez aucun groupe pour le moment. Commencez à échanger des dépense avec des amis, ou créez un groupe pour commencer !",
                    ),
                  ],
                ),
              )
            else
              ...conversationListController.groups.map((group) {
                return ConversationButtonWidget(
                  nom: group.name,
                  sousTitre: "WOW",
                  group: group,
                  onPressed: () {},
                );
              }),
        ],
      ),
    );
  }
}
