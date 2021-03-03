import 'package:Daily_Expense/model/Transaction.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:intl/intl.dart';

class TransactionList extends StatelessWidget {
  final List<Transaction> _userTransactions;
  final Function deleteTrans;

  TransactionList(this._userTransactions, this.deleteTrans);

  @override
  Widget build(BuildContext context) {
    return new Container(
        child:_userTransactions.isEmpty ? LayoutBuilder(builder: (context,constrains){
          return Column(
            children: [
              SizedBox(height: 10),
              Text("No transaction yet!",style: Theme.of(context).textTheme.headline6),
              Container(
                  height: constrains.maxHeight* 0.6,
                  margin: EdgeInsets.only(top: 20),
                  child: Image.asset('assets/images/waiting.png',fit: BoxFit.cover))
            ],
          );
        }) :ListView.builder(
                scrollDirection:Axis.vertical,
                itemCount: _userTransactions.length,
                itemBuilder: (ctx,index){
                return /*Card(
              elevation: 2,
              child: Row(
                children: <Widget>[
                  Container(
                    margin: EdgeInsets.symmetric(vertical: 10,horizontal:10),
                    decoration: BoxDecoration(border: Border.all(width: 2,color: Theme.of(context).primaryColor)),
                    padding: EdgeInsets.all(10),
                    child: Text("${_userTransactions[index].amount.toStringAsFixed(2)} /-",
                      style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 20,
                          color: Theme.of(context).primaryColor
                      )
                    )
                  ),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(_userTransactions[index].title,style: Theme.of(context).textTheme.headline6),
                      Text(DateFormat.yMMMd().format(_userTransactions[index].date),style:TextStyle(fontSize: 16,color: Colors.grey,fontWeight: FontWeight.bold))
                    ],
                  )
                ],
              ),
            );*/ Card(
                  elevation: 2,
                  margin: EdgeInsets.symmetric(vertical: 4,horizontal: 5),
                  child: ListTile(
                      leading: Container (
                        height: 60,
                        width: 60,
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          color: Theme.of(context).primaryColor
                        ),
                        child: Padding(padding: EdgeInsets.all(8),child: FittedBox(child: Text("${_userTransactions[index].amount} /-",style: Theme.of(context).textTheme.headline6))),
                      ),
                      title: Text("${_userTransactions[index].title}",style: Theme.of(context).textTheme.headline6),
                      subtitle:Text(DateFormat.yMMMd().format(_userTransactions[index].date)),
                      trailing: IconButton(
                        icon: Icon(Icons.delete),
                        color: Theme.of(context).errorColor,
                        onPressed:() =>deleteTrans(_userTransactions[index].id),
                      ),
                    ),
            );
                }
        ));
    }

}