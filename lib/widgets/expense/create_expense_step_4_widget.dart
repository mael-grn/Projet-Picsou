import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:projet_picsou/controllers/home/create_expense_controller.dart';
import 'package:projet_picsou/core/theme/app_theme.dart';
import 'package:projet_picsou/core/custom_navigator.dart';
import 'package:projet_picsou/dialogs/alert_dialog_builder.dart';
import 'package:projet_picsou/utils/date_utils.dart';
import 'package:projet_picsou/views/user_profile_view.dart';
import 'package:projet_picsou/widgets/animations/slide_fade_animation_widget.dart';
import 'package:projet_picsou/widgets/list_item_profile_elem_widget.dart';
import 'package:projet_picsou/widgets/ui/Text_field_widget.dart';
import 'package:projet_picsou/widgets/ui/button_widget.dart';
import 'package:projet_picsou/widgets/ui/popup_page_widget.dart';
import 'package:projet_picsou/widgets/ui/text_info_widget.dart';
import 'package:provider/provider.dart';

import '../../models/expense.dart';
import '../../models/group.dart';
import '../../models/user.dart';
import '../animations/slide_fade_animation_from_right_widget.dart';

class CreateExpenseStep4Widget extends StatelessWidget {

  const CreateExpenseStep4Widget({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = context.watch<CreateExpenseController>();
    return SlideFadeAnimationFromRightWidget(
      child: Column(
        children: [
          SizedBox(height: 20),
          Text(
            "Encore quelques détails",
            style: TextStyle(fontSize: 35, fontWeight: FontWeight.bold),
          ),
          SizedBox(height: 40),
          Form(
              child: Column(
                children: [
                  TextFieldWidget(
                    controller: controller.nameController,
                    labelText: "Nom de la dépense",
                  ),
                  SizedBox(height: 20),
                  TextFieldWidget(
                    controller: controller.descriptionController,
                    labelText: "Déscription (facultatif)",
                  ),
                  SizedBox(height: 20),
                  TextInfoWidget("Date : ", CustomDateUtils.getDateString(controller.date)),
                  SizedBox(height: 10),
                  ButtonWidget(
                      message: "Selectionner une date",
                      icon: Icons.calendar_month,
                      onPressed: () {
                        DialogBuilder.datePicker(
                          controller.setDate,
                          initialDate: controller.date
                        );
                      }
                  )
                ],
              )
          ),
        ],
      ),
    );
  }
}
