import 'package:flutter/material.dart';
import 'package:projet_picsou/controllers/home/group_expense_controller.dart';
import 'package:projet_picsou/controllers/home/home_controller.dart';
import 'package:projet_picsou/core/theme/app_theme.dart';
import 'package:projet_picsou/views/home/create_expense_view.dart';
import 'package:projet_picsou/widgets/groups/groupe_list_item_widget.dart';
import 'package:projet_picsou/widgets/list_item_profile_elem_widget.dart';
import 'package:projet_picsou/widgets/ui/button_widget.dart';
import 'package:projet_picsou/widgets/ui/popup_page_widget.dart';
import 'package:provider/provider.dart';
import '../../core/custom_navigator.dart';
import '../../models/group.dart';
import '../../models/user.dart';
import '../../widgets/ui/main_page_layout_widget.dart';
import 'create_group_view.dart';

class GroupExpenseView extends StatefulWidget {
  final Group group;
  const GroupExpenseView({required this.group, super.key});

  @override
  State<GroupExpenseView> createState() => _GroupExpenseViewState();
}

class _GroupExpenseViewState extends State<GroupExpenseView> {
  @override

  @override
  void initState() {
    super.initState();
    final controller = Provider.of<GroupExpenseController>(context, listen: false);
    WidgetsBinding.instance.addPostFrameCallback((_) {
      controller.initData(widget.group);
    });
  }

  @override
  Widget build(BuildContext context) {
    final controller = context.watch<GroupExpenseController>();


    return PopupPageWidget(
        body: Column(
          children: [],
        )
    );
  }
}
