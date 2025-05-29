import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:projet_picsou/controllers/home/create_expense_controller.dart';
import 'package:projet_picsou/core/theme/app_theme.dart';
import 'package:projet_picsou/core/custom_navigator.dart';
import 'package:projet_picsou/views/user_profile_view.dart';
import 'package:projet_picsou/widgets/animations/slide_fade_animation_from_right_widget.dart';
import 'package:projet_picsou/widgets/animations/slide_fade_animation_widget.dart';
import 'package:projet_picsou/widgets/list_item_profile_elem_widget.dart';
import 'package:projet_picsou/widgets/ui/button_widget.dart';
import 'package:projet_picsou/widgets/ui/popup_page_widget.dart';
import 'package:provider/provider.dart';

import '../../enums/expense_type_enum.dart';
import '../../models/group.dart';
import '../../models/user.dart';
import '../ui/Text_field_widget.dart';

class CreateExpenseStep3Widget extends StatelessWidget {
  const CreateExpenseStep3Widget({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = context.watch<CreateExpenseController>();
    return SlideFadeAnimationFromRightWidget(
      child: Column(
        children: [
          SizedBox(height: 20),
          Text(
            "Qui en profite ?",
            style: TextStyle(fontSize: 35, fontWeight: FontWeight.bold),
          ),
          SizedBox(height: 20),
          Text(
            "Montant à partager : ${controller.totalAmount} €",
            style: TextStyle(fontSize: 20),
          ),
          SizedBox(height: 20),
          Container(
            decoration: BoxDecoration(
              color: foregroundVariantColor,
              borderRadius: BorderRadius.circular(12),
            ),
            padding: EdgeInsets.symmetric(horizontal: 12),
            child: DropdownButton<ExpenseTypeEnum>(
              value: controller.expenseType,
              borderRadius: BorderRadius.circular(12),
              dropdownColor: foregroundVariantColor,
              icon: Icon(Icons.arrow_drop_down, color: backgroundColor),
              underline: SizedBox(),
              items:
                  ExpenseTypeEnum.values.map((s) {
                    return DropdownMenuItem<ExpenseTypeEnum>(
                      value: s,
                      child: Text(
                        style: TextStyle(color: backgroundColor),
                        s.name,
                      ),
                    );
                  }).toList(),
              onChanged: (val) {
                if (val != null) {
                  controller.setExpenseType(val);
                }
              },
            ),
          ),
          SizedBox(height: 40),
          Column(
            children:
                controller.groupMembers.asMap().entries.map((entry) {
                  final i = entry.key;
                  final member = entry.value;
                  return Column(
                    children: [
                      Container(
                        padding: EdgeInsets.all(20),
                        decoration: BoxDecoration(
                          color: foregroundVariantColor,
                          borderRadius: BorderRadius.circular(35),
                        ),
                        child: Column(
                          children: [
                            ListItemProfileElemWidget(
                              id: member.user.id,
                              onTap: () {
                                controller.toggleParticipant(member);
                              },
                              color:
                                  controller.isParticipant(member)
                                      ? secondaryColor
                                      : backgroundColor,
                              imageUrl: member.user.profilPictureRef,
                              name:
                                  "${member.user.firstName} ${member.user.lastName}",
                              addGapAfter: false,
                            ),
                            if (controller.isParticipant(member))
                              SizedBox(height: 20),
                            if (controller.isParticipant(member))
                              controller.expenseType == ExpenseTypeEnum.amount
                                  ? TextFieldWidget(
                                    enabledBorder: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(25),
                                      borderSide: BorderSide(
                                        color: secondaryColor,
                                        width: 0,
                                      ),
                                    ),
                                    focusedBorder: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(25),
                                      borderSide: BorderSide(
                                        color: secondaryColor,
                                        width: 0,
                                      ),
                                    ),
                                    labelText: "Montant",
                                    keyboardType: TextInputType.number,
                                    inputFormatters: [
                                      FilteringTextInputFormatter.digitsOnly,
                                    ],
                                    onChanged: (value) {
                                      controller.updateAmountForParticipant(
                                        member,
                                        double.parse(
                                          value.isEmpty ? '0' : value,
                                        ),
                                      );
                                    },
                                  )
                                  : Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceAround,
                                    children: [
                                      IconButton(
                                        icon: Icon(
                                          color: backgroundColor,
                                            Icons.remove
                                        ),
                                        onPressed: () {
                                          controller
                                              .decreaseParticipantPartNumber(
                                                member,
                                              );
                                        },
                                      ),
                                      Text(
                                        '${controller.getPartNumberForParticipant(member)}',
                                        style: TextStyle(
                                          color: backgroundColor,
                                          fontSize: 20,
                                          fontWeight: FontWeight.bold,
                                        ),
                                      ),
                                      IconButton(
                                        icon: Icon(
                                          color: backgroundColor,
                                            Icons.add
                                        ),
                                        onPressed: () {
                                          controller
                                              .increaseParticipantPartNumber(
                                                member,
                                              );
                                        },
                                      ),
                                      SizedBox(width: 20),
                                      Text(
                                        style: TextStyle(
                                          color: backgroundColor,
                                          fontSize: 20,
                                          fontWeight: FontWeight.bold,
                                        ),
                                        "${controller.getAmountForParticipant(member)} €",
                                      ),
                                    ],
                                  ),
                          ],
                        ),
                      ),
                      if (i < controller.groupMembers.length - 1)
                        SizedBox(height: 10),
                    ],
                  );
                }).toList(),
          ),
        ],
      ),
    );
  }
}
