import 'package:flutter/cupertino.dart';

import '../../controllers/conversation_list_controller.dart';
import '../../core/provider.dart';

class ExpensesWidget extends StatefulWidget{
  const ExpensesWidget({super.key});
  @override
  State<ExpensesWidget> createState() => _ExpensesWidgetState();
}

class _ExpensesWidgetState extends State<ExpensesWidget> {

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
    return Container(
      child: Text("Expenses"),
    );
  }
}

