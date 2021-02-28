import 'package:Daily_Expense/model/Transaction.dart';
import 'package:Daily_Expense/widget/ChartBar.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class Chart extends StatelessWidget {
  final List<Transaction> recentTransaction;

  Chart(this.recentTransaction);

  List<Map<String, Object>> get groupedTransaction {
    return List.generate(7, (index) {
      final weekday = DateTime.now().subtract(Duration(days: index));
      double totalAmount = 0.0;
      for (var i = 0; i < recentTransaction.length; i++) {
        if (recentTransaction[i].date.day == weekday.day &&
            recentTransaction[i].date.month == weekday.month &&
            recentTransaction[i].date.year == weekday.year) {
          totalAmount +=recentTransaction[i].amount;
        }
      }
      return {
        "day": DateFormat.E().format(weekday).substring(0,1),
        "amount": totalAmount};
      }
    ).reversed.toList();
  }

  double get totalSpending{
    return groupedTransaction.fold(0.0, (sum,item) {
      return sum + item["amount"];
    });
  }

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 6,
      margin: EdgeInsets.all(20),
      child: Padding(
        padding: EdgeInsets.all(10),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: groupedTransaction.map((data){
           return ChartBar(data["day"],data["amount"], totalSpending==0.0? 0.0 : (data["amount"] as double)/totalSpending);
          }).toList()
        ),
      ),
    );
  }
}
