import 'package:Daily_Expense/widget/NewTransaction.dart';
import 'package:Daily_Expense/widget/TransactionList.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:Daily_Expense/widget/Chart.dart';
import 'model/Transaction.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: Colors.amber,
        accentColor: Colors.orange,
        fontFamily: 'OpenSans',
        appBarTheme: AppBarTheme(
            textTheme: ThemeData.light().textTheme.copyWith(
                headline6: TextStyle(fontFamily: 'OpenSans', fontSize: 20))),
        textTheme: ThemeData.fallback().textTheme.copyWith(
            headline6: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.bold,
                fontFamily: 'OpenSans'),
            headline5: TextStyle(
                fontSize: 16,
                fontFamily: 'OpenSans'),
            headline4: TextStyle(
                fontSize: 16,
                color: Colors.white,
                fontFamily: 'OpenSans'))
      ),
      home: MyHomePage(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  final List<Transaction> _userTransactions = [ /*Transaction(id: "t1",title: "Shoe",amount: 800,date: DateTime.now()),
    Transaction(id: "t1",title: "Glass",amount: 500,date: DateTime.now()),
    Transaction(id: "t1",title: "Food",amount: 125,date: DateTime.now()),
    Transaction(id: "t1",title: "Medicine",amount: 665,date: DateTime.now()),
    Transaction(id: "t1",title: "Shoe",amount: 800,date: DateTime.now()),
    Transaction(id: "t1",title: "Glass",amount: 500,date: DateTime.now()),
    Transaction(id: "t1",title: "Food",amount: 125,date: DateTime.now()),
    Transaction(id: "t1",title: "Medicine",amount: 665,date: DateTime.now()),
    Transaction(id: "t1",title: "Shoe",amount: 800,date: DateTime.now()),
    Transaction(id: "t1",title: "Glass",amount: 500,date: DateTime.now()),
    Transaction(id: "t1",title: "Food",amount: 125,date: DateTime.now()),
    Transaction(id: "t1",title: "Medicine",amount: 665,date: DateTime.now()),
    Transaction(id: "t1",title: "Shoe",amount: 800,date: DateTime.now())*/ ];

  List<Transaction> get _recentTrans {
    return _userTransactions.where((tx) {
      return tx.date.isAfter(DateTime.now().subtract(Duration(days: 7)));
    }).toList();
  }

  void _addNewTransAction(String title, double amount, DateTime date) {
    Transaction newTrns = new Transaction(
        id: DateTime.now().toString(),
        title: title,
        amount: amount,
        date: date);
    setState(() {
      _userTransactions.add(newTrns);
    });
  }

  void _startNewTransaction(BuildContext ctx) {
    showModalBottomSheet(
        context: ctx,
        builder: (_) {
          return GestureDetector(
              onTap: () {},
              child: NewTransaction(_addNewTransAction),
              behavior: HitTestBehavior.opaque);
        });
  }

  void _deleteTransaction(String id){
     setState(() {
       _userTransactions.removeWhere((Tx) => Tx.id==id);
     });

  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Daily Expense"),
        actions: <Widget>[
          IconButton(
              icon: Icon(Icons.add),
              onPressed: () {
                _startNewTransaction(context);
              })
        ],
      ),
      body: SingleChildScrollView(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: <Widget>[
            /*Container(
              width: double.infinity,
              padding: EdgeInsets.all(8),
              alignment: Alignment.center,
              child:Text("Daily Expence Chart",style: TextStyle(fontSize: 18,color: Colors.black,fontWeight: FontWeight.bold))
            ),*/
            Chart(_recentTrans),
            TransactionList(_userTransactions,_deleteTransaction)
          ],
        ),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
      floatingActionButton: FloatingActionButton(
          child: Icon(Icons.add),
          onPressed: () {
            _startNewTransaction(context);
          }),
    );
  }
}
