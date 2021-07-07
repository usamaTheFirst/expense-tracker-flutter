import 'package:expense_tracker/transaction.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:intl/intl.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
        textTheme: TextTheme(
            headline1: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
                color: Colors.purple),
            headline2: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.bold,
                color: Colors.black87)),
      ),
      home: MyHomePage(),
    );
  }
}

class MyHomePage extends StatelessWidget {
  final List<Transaction> transactions = [
    Transaction(
        id: 't1', amount: 69.420, title: 'New Shoes', date: DateTime.now()),
    Transaction(
        id: 't2', amount: 420.69, title: 'New Shirt', date: DateTime.now())
  ];
  String title, amount;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Transaction App'),
      ),
      body: Center(
        child: Center(
          child: Column(
            // crossAxisAlignment: CrossAxisAlignment.stretch,
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Container(
                width: double.infinity,
                child: Card(
                  color: Colors.blue,
                  child: Text('Chart',
                      style: Theme.of(context).textTheme.headline1),
                  // color: Colors.purpleAccent,
                  // margin: EdgeInsets.all(50),
                  elevation: 5,
                ),
              ),
              Card(
                elevation: 5,
                child: Container(
                  padding: EdgeInsets.all(5),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.end,
                    children: [
                      TextField(
                        decoration: InputDecoration(
                          labelText: 'Title',
                        ),
                        onChanged: (value) {
                          title = value;
                        },
                      ),
                      TextField(
                        decoration: InputDecoration(labelText: 'Amount'),
                        onChanged: (value) {
                          amount = value;
                        },
                      ),
                      TextButton(
                          onPressed: () {
                            print(title);
                            print(amount);
                          },
                          child: Text(
                            "Add Transaction",
                            style: TextStyle(color: Colors.purple),
                          ))
                    ],
                  ),
                ),
              ),
              Column(
                children: transactions.map((tx) {
                  return Card(
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        Container(
                          margin: EdgeInsets.symmetric(
                              horizontal: 15, vertical: 10),
                          padding: EdgeInsets.all(10),
                          child: Text(
                            '${tx.amount}\$',
                            style: Theme.of(context).textTheme.headline1,
                          ),
                          decoration: BoxDecoration(
                            border: Border.all(color: Colors.purple, width: 3),
                            // borderRadius: BorderRadius.circular(10),
                          ),
                        ),
                        // Spacer(),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              '${tx.title}',
                              style: Theme.of(context).textTheme.headline2,
                            ),
                            Text(
                              DateFormat('yMMMd').format(tx.date),
                              style:
                                  TextStyle(color: Colors.grey, fontSize: 14),
                            )
                          ],
                        ),
                      ],
                    ),
                  );
                }).toList(),
              ),
            ],
          ),
        ),
      ),
      // This trailing comma makes auto-formatting nicer for build methods.
    );
  }
}
