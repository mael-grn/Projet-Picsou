import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:projet_picsou/controllers/home/create_expense_controller.dart';
import 'package:projet_picsou/controllers/home/create_group_controller.dart';
import 'package:projet_picsou/core/theme/app_theme.dart';
import 'package:projet_picsou/models/friend_request.dart';
import 'package:projet_picsou/models/group.dart';
import 'package:projet_picsou/widgets/friends/friend_request_list_item_widget.dart';
import 'package:projet_picsou/widgets/ui/popup_page_widget.dart';
import 'package:provider/provider.dart';
import '../../controllers/me/edit_paiement_data_controller.dart';
import '../../controllers/me/edit_personal_data_controller.dart';
import '../../dialogs/alert_dialog_builder.dart';
import '../../models/user.dart';
import '../../widgets/animations/scale_animation_widget.dart';
import '../../widgets/ui/Text_field_widget.dart';
import '../../widgets/ui/button_widget.dart';

class CreateExpenseView extends StatefulWidget {
  CreateExpenseView({super.key});

  final _formKey = GlobalKey<FormState>();

  @override
  _CreateExpenseViewState createState() => _CreateExpenseViewState();
}

class _CreateExpenseViewState extends State<CreateExpenseView> {

  @override
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      final controller = context.read<CreateExpenseController>();
      controller.reset();
      controller.initData();
    });
  }

  @override
  Widget build(BuildContext context) {
    final controller = context.watch<CreateExpenseController>();

    return Scaffold(
        appBar: AppBar(
          backgroundColor: backgroundColor,
          elevation: 0,
          scrolledUnderElevation: 0,
          title: Text(
            "Créer une dépense",
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
            style: const TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
      body: Stack(
        children: [
          SingleChildScrollView(
            child: Column(
              children: [
                Padding(
                    padding: EdgeInsets.all(20),
                  child: CreateExpenseStep.fromIndex(controller.currentStepIndex).page,
                ),
                SizedBox(height: 130),
              ],
            ),
          ),

          Positioned(
            bottom: 0,
              left: 0,
              right: 0,
              child: Container(
                padding: EdgeInsets.fromLTRB(20, 20, 20, 35),
                decoration: BoxDecoration(
                    color: backgroundColor
                ),
                child: Row(
                  children: [
                    if (controller.currentStepIndex != 4)
                    Expanded(
                        child: ButtonWidget(
                            disabled: !controller.canGoToPreviousStep(),
                            message: "Précédent",
                            icon: Icons.arrow_back_ios_rounded,
                            onPressed: controller.previousStep
                        )
                    ),
                    if (controller.currentStepIndex != 4)
                    SizedBox(width: 20),
                    Expanded(
                        child: ButtonWidget(
                          tag: "create_expense",
                            disabled: !controller.canGoToNextStep(),
                            backgroundColor: primaryColor,
                            message: controller.currentStepIndex == 4 ? "Créer la dépense" : "Suivant",
                            icon: controller.currentStepIndex == 4 ? Icons.add : Icons.arrow_forward_ios_rounded,
                            onPressed: controller.currentStepIndex == 4 ? controller.createExpense : controller.nextStep,
                          iconOnRight: true,
                        )
                    )
                  ],
                ),
              ),
          )
        ],
      ),
    );
  }
}