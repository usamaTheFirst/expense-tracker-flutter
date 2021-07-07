import 'package:flutter/material.dart';

class NewTransaction extends StatelessWidget {
  TextEditingController titleController = TextEditingController();
  TextEditingController amountController = TextEditingController();
  final Function onPresses;

  NewTransaction({Key key, this.onPresses}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 5,
      child: Container(
        padding: EdgeInsets.all(5),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.end,
          children: [
            TextField(
              controller: titleController,
              decoration: InputDecoration(
                labelText: 'Title',
              ),
            ),
            TextField(
              controller: amountController,
              decoration: InputDecoration(labelText: 'Amount'),
            ),
            TextButton(
                onPressed: () {
                  print(titleController.text);
                  print(amountController.text);
                  onPresses(titleController.text,
                      double.parse(amountController.text));
                },
                child: Text(
                  "Add Transaction",
                  style: TextStyle(color: Colors.purple),
                ))
          ],
        ),
      ),
    );
  }
}
