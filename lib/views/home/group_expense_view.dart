import 'package:flutter/material.dart';
import 'package:projet_picsou/controllers/home/group_expense_controller.dart';
import 'package:projet_picsou/widgets/expense/expense_list_elem_widget.dart';
import 'package:projet_picsou/widgets/list_item_profile_elem_widget.dart';
import 'package:provider/provider.dart';
import '../../core/custom_navigator.dart';
import '../../core/theme/app_theme.dart';
import '../../models/group.dart';
import '../../widgets/ui/button_widget.dart';
import 'create_expense_view.dart';

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
    final controller = Provider.of<GroupExpenseController>(
      context,
      listen: false,
    );
    WidgetsBinding.instance.addPostFrameCallback((_) {
      controller.initData(widget.group);
    });
  }

  @override
  Widget build(BuildContext context) {
    final controller = context.watch<GroupExpenseController>();

    if (controller.group == null) {
      return const Center(child: CircularProgressIndicator());
    }

    return Scaffold(
      appBar: AppBar(
        backgroundColor: backgroundVariantColor,
        elevation: 0,
        scrolledUnderElevation: 0,
        title: Row(
          children: [
            CircleAvatar(
              backgroundImage: NetworkImage(controller.group!.pictRef),
              radius: 20,
            ),
            const SizedBox(width: 12),
            Expanded(
              child: Text(
                controller.group!.name,
                style: const TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.w600,
                ),
                overflow: TextOverflow.ellipsis,
              ),
            ),
          ],
        ),
      ),
      body: Column(
        children: [
          Expanded(
            child: Stack(
              children: [
                Align(
                  alignment: controller.expenses.isEmpty ? Alignment.center : Alignment.bottomCenter,
                  child: Padding(
                      padding: EdgeInsets.fromLTRB(20, 0, 20, 20),
                    child: SingleChildScrollView(
                      reverse: true,
                      child: controller.expenses.isEmpty ?
                      Column(
                        children: [
                          Image.asset(width: 300, "images/searching.png"),
                          SizedBox(height: 20),
                          Text(
                            textAlign: TextAlign.center,
                            style: TextStyle(
                              fontSize: 30,
                              fontWeight: FontWeight.bold,
                            ),
                            "Vous n'avez pas encore créé de dépenses",
                          ),
                          SizedBox(height: 10),
                          Text(
                            style: TextStyle(fontSize: 17),
                            textAlign: TextAlign.center,
                            "Pour commencer, appuyez sur le bouton ci-dessous pour créer une dépense.",
                          ),
                        ],
                      ) :
                      Column(
                        mainAxisSize: MainAxisSize.min,
                        children:
                        controller.expenses.map((expense) {
                          return ExpenseListElemWidget(
                            expense: expense.expense,
                            onTap: () {},
                          );
                        }).toList(),
                      ),
                    ),
                  )
                ),
              ],
            ),
          ),

          GestureDetector(
            onTap: () => CustomNavigator.pushFromBottom(CreateExpenseView(specifiedGroup: controller.group)),
            child: Container(
              width: double.infinity,
              height: 110,
              decoration: BoxDecoration(
                color: foregroundVariantColor,
                borderRadius: BorderRadius.circular(30),
              ),
              child: Center(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    mainAxisSize: MainAxisSize.max,
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        mainAxisSize: MainAxisSize.max,
                        children: [
                          Text(
                            "Créer une dépense",
                            style: TextStyle(
                              color: backgroundColor,
                              fontSize: 18,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                          const SizedBox(width: 10),
                          Icon(
                            Icons.add,
                            color: backgroundColor,
                            size: 30,
                          ),
                        ],
                      ),
                      SizedBox(height: 20)
                    ],
                  )
              ),
            ),
          )
        ],
      ),
    );
  }
}
