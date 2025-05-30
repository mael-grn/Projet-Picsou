import 'dart:math';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:projet_picsou/core/theme/app_theme.dart';
import 'package:projet_picsou/core/custom_navigator.dart';
import 'package:projet_picsou/models/expense.dart';
import 'package:projet_picsou/utils/date_utils.dart';
import 'package:projet_picsou/utils/string_utils.dart';
import 'package:projet_picsou/views/user_profile_view.dart';
import 'package:projet_picsou/widgets/ui/button_widget.dart';
import 'package:provider/provider.dart';

import '../../models/group.dart';
import '../../models/user.dart';

class ExpenseListElemWidget extends StatelessWidget {
  final Expense expense;
  final Function? onTap;

  const ExpenseListElemWidget({
    super.key,
    required this.expense,
    this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        GestureDetector(
          onTap: () {
            if (onTap != null) {
              HapticFeedback.mediumImpact();
              onTap!();
            }
          },
          child: Container(
            decoration: BoxDecoration(
              color: primaryColor,
              borderRadius: BorderRadius.circular(25),
            ),
            padding: EdgeInsets.all(10),
            child: Row(
              mainAxisSize: MainAxisSize.max,
              children: [
                Container(
                  width: 75,
                  height: 75,
                  decoration: BoxDecoration(
                    color: secondaryColor,
                    borderRadius: BorderRadius.circular(100),
                  ),
                  child: Center(
                    child: Icon(Icons.monetization_on_outlined, size: 45),
                  ),
                ),
                SizedBox(width: 15),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      expense.name,
                      style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                        color: foregroundColor,
                      ),
                      overflow: TextOverflow.ellipsis,
                    ),
                    SizedBox(height: 5),
                    Text(
                      "${expense.amount} \$ ● ${CustomDateUtils.getDateString(expense.date)}",
                      style: TextStyle(
                        fontSize: 15,
                        color: foregroundVariantColor,
                      ),
                    ),
                  ],
                )
              ],
            ),
          ),
        ),
        SizedBox(height: 10),
      ],
    );
  }
}
