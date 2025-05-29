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

import '../../models/group.dart';
import '../../models/user.dart';
import '../ui/Text_field_widget.dart';

class CreateExpenseStep2Widget extends StatelessWidget {
  const CreateExpenseStep2Widget({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = context.watch<CreateExpenseController>();
    return SlideFadeAnimationFromRightWidget(
      child: Column(
        children: [
          SizedBox(height: 20),
          Text(
            "Qui a payé ?",
            style: TextStyle(fontSize: 35, fontWeight: FontWeight.bold),
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
                                controller.toggleContributor(member);
                              },
                              color:
                              controller.isContributor(member)
                                  ? secondaryColor
                                  : backgroundColor,
                              imageUrl: member.user.profilPictureRef,
                              name:
                              "${member.user.firstName} ${member.user.lastName}",
                              addGapAfter: false,
                            ),
                            if (controller.isContributor(member))
                              SizedBox(height: 20),
                            if (controller.isContributor(member))
                              TextFieldWidget(
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
                                  controller.updateAmountForContributor(
                                    member,
                                    double.parse(value.isEmpty ? '0' : value),
                                  );
                                },
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
