import 'package:flutter/material.dart';

class NewTransaction extends StatefulWidget {
  final Function onPresses;

  NewTransaction({Key key, this.onPresses}) : super(key: key);

  @override
  _NewTransactionState createState() => _NewTransactionState();
}

class _NewTransactionState extends State<NewTransaction> {
  TextEditingController titleController = TextEditingController();

  TextEditingController amountController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 5,
      child: Container(
        padding: EdgeInsets.all(5),
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
                  Text('No date chosen'),
                  FlatButton(
                    textColor: Theme.of(context).primaryColor,
                    onPressed: () {},
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
      ),
    );
  }

  void addTransaction() {
    try {
      var enteredAmount = double.parse(amountController.text);
      var enteredTitle = titleController.text;
      if (enteredTitle != null && enteredAmount != null && enteredAmount >= 0)
        widget.onPresses(enteredTitle, enteredAmount);

      Navigator.pop(context);
    } catch (e) {}
  }
}
