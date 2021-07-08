import 'package:expense_tracker/widgets/new_transaction.dart';
import 'package:expense_tracker/widgets/transaction_list.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

import 'models/transaction.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
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

class MyHomePage extends StatefulWidget {
  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  final List<Transaction> transactions = [
    Transaction(
        id: 't1', amount: 69.420, title: 'New Shoes', date: DateTime.now()),
    Transaction(
        id: 't2', amount: 420.69, title: 'New Shirt', date: DateTime.now())
  ];
  void _addNewTransaction(String title, double amount) {
    transactions.add(Transaction(
        id: DateTime.now().toString(),
        title: title,
        amount: amount,
        date: DateTime.now()));
    setState(() {});
  }

  startAddNewTransaction(BuildContext ctx) {
    showModalBottomSheet(
        context: ctx,
        builder: (bCtx) {
          return SingleChildScrollView(
            child: NewTransaction(
              onPresses: _addNewTransaction,
            ),
          );
        });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Transaction App'),
        actions: [
          IconButton(
            icon: Icon(
              Icons.add,
              color: Colors.white,
            ),
            onPressed: () => startAddNewTransaction(context),
          )
        ],
      ),
      body: SingleChildScrollView(
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
              TransactionList(transactions: transactions),
            ],
          ),
        ),
      ),

      // This trailing comma makes auto-formatting nicer for build methods.
      floatingActionButton: FloatingActionButton(
        onPressed: () => startAddNewTransaction(context),
        child: Icon(Icons.add),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
    );
  }
}
