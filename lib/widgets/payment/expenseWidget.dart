import 'package:flutter/material.dart';
import 'package:projet_picsou/core/theme/app_theme.dart';
import 'package:projet_picsou/models/expense.dart';

import '../../utils/date_utils.dart';


class ExpenseWidget extends StatelessWidget {

  final Expense expense;
  const ExpenseWidget(this.expense, {super.key});

  @override
  Widget build(BuildContext context) {

    return Column(
      children: [

        TextButton(

            onPressed: (){print("test");},
            style: ButtonStyle(
              backgroundColor: expense.myShare > 0 ? WidgetStateProperty.all(darkColor) : WidgetStateProperty.all(Colors.transparent),
              shape: WidgetStateProperty.all(
                RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(15), // Modifier ici le border radius
                ),
              ),
            ),
            child: Container(
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [

                        Container(
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(100),
                          ),
                          clipBehavior: Clip.antiAlias,
                          width: 40,
                          height: 40,
                          child: Icon(
                            size: 40,
                              Icons.monetization_on
                          )
                        ),

                        SizedBox(width: 5),

                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                                textAlign: TextAlign.left,
                                style: TextStyle(
                                    fontWeight: FontWeight.w900,
                                    fontSize: 18
                                ),
                                expense.name
                            ),
                            SizedBox(height: 3),
                            Row(
                                mainAxisAlignment: MainAxisAlignment.start,
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: [
                                  Icon(
                                    size: 15,
                                      Icons.calendar_month
                                  ),
                                  SizedBox(width: 5),
                                  Text(
                                      textAlign: TextAlign.left,
                                      style: TextStyle(
                                        fontSize: 12,
                                        fontWeight: FontWeight.normal,
                                      ),
                                      CustomDateUtils.getDateString(expense.date)
                                  )
                                ]
                            )
                          ],
                        ),
                      ],
                    ),


                    Text(
                        textAlign: TextAlign.left,
                        style: TextStyle(
                            fontWeight: FontWeight.w900,
                            fontSize: 25
                        ),
                      '${expense.myShare.toString()} €'
                    )
                  ]
                )
            )
        ),

        SizedBox(height: 5),
      ],
    ) ;
  }
}