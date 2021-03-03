import 'package:flutter/material.dart';

class ChartBar extends StatelessWidget {
  final String lable;
  final double spendingAmount, spendingAmountParcentage;

  ChartBar(this.lable, this.spendingAmount, this.spendingAmountParcentage);

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context,Constrains){
        return Column(
          children: [
            Container(height: Constrains.maxHeight*0.15,child: FittedBox(child: Text("${spendingAmount.toStringAsFixed(0)} /-"))),
            SizedBox(height:  Constrains.maxHeight*0.05),
            Container(
              height:  Constrains.maxHeight*0.6,
              width: 10,
              child: Stack(
                children: <Widget>[
                  Container(
                      decoration: BoxDecoration(
                          border: Border.all(color: Colors.grey, width: 1.0),
                          color: Color.fromRGBO(220, 220, 220, 1),
                          borderRadius: BorderRadius.circular(10))),
                  FractionallySizedBox(
                      heightFactor: spendingAmountParcentage,
                      child: Container(
                        decoration: BoxDecoration(
                            color: Theme.of(context).primaryColor,
                            borderRadius: BorderRadius.circular(10)),
                      ))
                ],
              ),
            ),
            SizedBox(
              height:  Constrains.maxHeight*0.05,
            ),
            Container(height : Constrains.maxHeight*0.15, child: FittedBox(child: Text(lable)))
          ],
        );
      },
    );
  }
}
