import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class NewTransaction extends StatefulWidget {
  final Function onPresses;

  NewTransaction({Key key, this.onPresses}) : super(key: key);

  @override
  _NewTransactionState createState() => _NewTransactionState();
}

class _NewTransactionState extends State<NewTransaction> {
  TextEditingController titleController = TextEditingController();

  TextEditingController amountController = TextEditingController();
  DateTime pickedDate;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.only(top: 10, left: 10, right: 10),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.end,
        children: [
          SizedBox(
            height: 10,
          ),
          TextField(
            autofocus: true,
            controller: titleController,
            textCapitalization: TextCapitalization.sentences,
            decoration: InputDecoration(
              labelText: 'Title',
            ),
          ),
          TextField(
            controller: amountController,
            keyboardType: TextInputType.number,
            decoration: InputDecoration(labelText: 'Amount'),
            onSubmitted: (_) => addTransaction(),
          ),
          Container(
            height: 70,
            child: Row(
              children: [
                Expanded(
                  child: Text(
                    pickedDate == null
                        ? 'No date chosen'
                        : 'Picked Date : ${DateFormat.yMd().format(pickedDate)}',
                  ),
                ),
                FlatButton(
                  textColor: Theme.of(context).primaryColor,
                  onPressed: _datePicker,
                  child: Text(
                    'Choose Date',
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                )
              ],
            ),
          ),
          RaisedButton(
              onPressed: addTransaction,
              color: Theme.of(context).primaryColor,
              child: Text(
                "Add Transaction",
                style: TextStyle(color: Colors.white),
              ))
        ],
      ),
    );
  }

  void addTransaction() {
    try {
      var enteredAmount = double.parse(amountController.text);
      var enteredTitle = titleController.text;
      if (enteredTitle != null &&
          enteredAmount != null &&
          enteredAmount >= 0 &&
          pickedDate != null)
        widget.onPresses(enteredTitle, enteredAmount, pickedDate);

      Navigator.pop(context);
    } catch (e) {}
  }

  _datePicker() {
    showDatePicker(
            context: context,
            initialDate: DateTime.now(),
            firstDate: DateTime(2021),
            lastDate: DateTime.now())
        .then((date) {
      if (date == null) {
        return;
      }
      setState(() {
        pickedDate = date;
      });
    });
  }
}
