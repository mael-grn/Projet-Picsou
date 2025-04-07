import 'package:flutter/material.dart';
import 'package:projet_picsou/core/theme/app_theme.dart';
import '../../models/refund.dart';
import '../../utils/date_utils.dart';

/// Widget that acts as a button, to show a glance of an expense.
/// It is intended to use this widget in a list.
class RefundWidget extends StatelessWidget {

  final Refund refund;
  const RefundWidget(this.refund, {super.key});

  @override
  Widget build(BuildContext context) {

    return Column(
      children: [

        TextButton(

            onPressed: (){print("test");},
            style: ButtonStyle(
              backgroundColor: WidgetStateProperty.all(primaryDarkColor),
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
                                border: Border.all(color: foregroundColor, width: 2)
                              ),
                              clipBehavior: Clip.antiAlias,
                              width: 40,
                              height: 40,
                              child: Icon(
                                  size: 20,
                                  Icons.call_received
                              )
                          ),

                          SizedBox(width: 10),

                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                  textAlign: TextAlign.left,
                                  style: TextStyle(
                                      fontWeight: FontWeight.w900,
                                      fontSize: 18
                                  ),
                                  "Remboursement"
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
                                        CustomDateUtils.getDateString(refund.date)
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
                          '${refund.amount.toString()} €'
                      )
                    ]
                )
            )
        ),

        SizedBox(height: 10),
      ],
    ) ;
  }
}