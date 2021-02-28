import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class NewTransaction extends StatefulWidget {
  final Function addNewTransaction;

  NewTransaction(this.addNewTransaction);

  @override
  _NewTransactionState createState() => _NewTransactionState();
}

class _NewTransactionState extends State<NewTransaction> {
  final _titleController = TextEditingController();
  final _amonutController = TextEditingController();
  DateTime _selectedDate;

  void _presentDatePicker() {
    showDatePicker(
            context: context,
            initialDate: DateTime.now(),
            firstDate: DateTime(2021),
            lastDate: DateTime.now())
        .then((pickedDate) {
      if (pickedDate == null) return;
      setState(() {
        print("state changed");
        _selectedDate = pickedDate;
      });
    });

  }

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.all(5),
      child: Card(
          elevation: 5,
          child: Container(
            padding: EdgeInsets.all(5),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.end,
              children: <Widget>[
                /*TextField(decoration: InputDecoration(labelText: "Title"),onChanged: (val)=>titleInput=val),
                  TextField(decoration: InputDecoration(labelText: "Amount"),onChanged: (val)=>amountInput=val),*/
                TextField(
                  decoration: InputDecoration(labelText: "Title"),
                  controller: _titleController,
                ),
                TextField(
                  decoration: InputDecoration(labelText: "Amount"),
                  controller: _amonutController,
                  keyboardType: TextInputType.number,
                ),
                Row(
                  children: <Widget>[
                    Text(_selectedDate == null
                        ? "No date chosen"
                        : DateFormat.yMd().format(_selectedDate)),
                    FlatButton(
                        onPressed:_presentDatePicker ,
                        child: Text(
                          "Chose date",
                          style: TextStyle(color: Colors.purple),
                        ))
                  ],
                ),
                FlatButton(
                    child: Text("Add Transaction"),
                    textColor: Colors.purple,
                    onPressed: () {
                      if(_amonutController.text.isEmpty){
                        return;
                      }
                      final enteredTitle=_titleController.text;
                      final enteredAmount=double.parse(_amonutController.text);
                      if (enteredTitle.isEmpty || enteredAmount <= 0 || _selectedDate == null) {
                        print("return called");
                        return;
                      }

                      widget.addNewTransaction(
                        enteredTitle,
                        enteredAmount,
                        _selectedDate,
                      );
                      Navigator.of(context).pop(); // close top most widget
                    })
              ],
            ),
          )),
    );
  }
}
