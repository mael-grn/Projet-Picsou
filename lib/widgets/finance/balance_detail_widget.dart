import 'package:flutter/widgets.dart';
import 'package:projet_picsou/controllers/payment_controller.dart';
import 'package:projet_picsou/core/theme/app_theme.dart';
import 'package:projet_picsou/models/test/negative_group_expense.dart';
import 'package:projet_picsou/widgets/finance/balance_widget.dart';
import '../../models/test/positive_group_expense.dart';
import 'package:flutter/material.dart';


class BalanceDetailWidget extends StatelessWidget{
  final PaymentController paymentController = PaymentController();
  final Function closeFunction;

  BalanceDetailWidget({required this.closeFunction, super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.only(
            topLeft: Radius.circular(20),
            topRight: Radius.circular(20)
        ),
        color: Color.fromRGBO(18, 64, 44, 1),
      ),
      child: Stack (
        children: [
          CustomScrollView(
          slivers: [
            SliverToBoxAdapter(
              child: Text("Balance Globale", textAlign: TextAlign.center,),
            ),
            SliverAppBar(
              actionsPadding: EdgeInsets.all(0),
              backgroundColor: Color.fromRGBO(18, 64, 44, 1),
              expandedHeight: 155.0,
              pinned: true,
              flexibleSpace: FlexibleSpaceBar(
                centerTitle: true,
                title: Container(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.all(Radius.circular(20)),
                    color: Color.fromRGBO(0, 255, 0, 0.8),
                  ),
                  padding: EdgeInsets.all(20),
                  child: BalanceWidget(),
                ),
              ),
            ),
            SliverList(
              delegate: SliverChildBuilderDelegate(
                childCount: 1,
                (context, index) => Column(
                  verticalDirection: VerticalDirection.down,
                  children: [
                    BalancePositive(paymentController: paymentController),
                    BalanceNegative(paymentController: paymentController)
                  ]
                )
              ),
            ),
          ],
        ),
        Positioned(
          top: 16.0,
          right: 16.0, 
          child: FloatingActionButton(
            focusColor: darkColor,
            backgroundColor: primaryColor,
            mini: true,
            onPressed: (){ closeFunction();},
            child: Icon(Icons.close),
          ),
        )
      ]
    )
    );
  }
}

class BalancePositive extends StatelessWidget {
  const BalancePositive({
    super.key,
    required this.paymentController,
  });

  final PaymentController paymentController;

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<double>(
      future: paymentController.getPositiveTot(),
      builder: (context, snapshot){
         if (snapshot.connectionState == ConnectionState.waiting){
          return(
            Column(
              children: [
                Text("On vous doit :"),
                Container(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.all(Radius.circular(20)),
                    color: Color.fromRGBO(0, 255, 0, 0.8),
                  ),
                  padding: EdgeInsets.all(20),
                  child: Text("Données en cours de chargement"),
                )
              ]
            )
          );
         }else if( snapshot.hasData ){
          return(
            Column(
              children: [
                Text("On vous doit :"),
                Container(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.all(Radius.circular(20)),
                    color: Color.fromRGBO(0, 255, 0, 0.8),
                  ),
                  padding: EdgeInsets.all(20),
                  child: Text("+${snapshot.data}"),
                )
              ]
            )
          );
         }else{
          return(
            Text("Erreur de chargement")
          );
         }
      }
    );
  }
}

class BalanceNegative extends StatelessWidget {
  const BalanceNegative({
    super.key,
    required this.paymentController,
  });

  final PaymentController paymentController;

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<double>(
      future: paymentController.getNegativeTot(),
      builder: (context, snapshot){
         if (snapshot.connectionState == ConnectionState.waiting){
          return(
            Column(
              children: [
                Text("Vous devez"),
                Container(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.all(Radius.circular(20)),
                    color: Color.fromRGBO(255, 0, 0, 0.8),
                  ),
                  padding: EdgeInsets.all(20),
                  child: Text("Données en cours de chargement"),
                )
              ]
            )
          );
         }else if( snapshot.hasData ){
          return(
            Column(
              children: [
                Text("Vous devez"),
                Container(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.all(Radius.circular(20)),
                    color: Color.fromRGBO(255, 0, 0, 0.8),
                  ),
                  padding: EdgeInsets.all(20),
                  child: Text(snapshot.data.toString()),
                )
              ]
            )
          );
         }else{
          return(
            Text("Erreur de chargement")
          );
         }
      }
    );
  }
}