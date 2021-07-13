import 'package:expense_tracker/widgets/chart.dart';
import 'package:expense_tracker/widgets/new_transaction.dart';
import 'package:expense_tracker/widgets/transaction_list.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'dart:io' show Platform;

import 'models/transaction.dart';

void main() {
  // WidgetsFlutterBinding.ensureInitialized();
  // SystemChrome.setPreferredOrientations(
  //     [DeviceOrientation.portraitUp, DeviceOrientation.portraitDown]);
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Personal Expenses',
      theme: ThemeData(
        appBarTheme: AppBarTheme(
          textTheme: ThemeData.light().textTheme.copyWith(
              headline6: TextStyle(
                  fontFamily: 'OpenSans',
                  fontSize: 20,
                  fontWeight: FontWeight.w600)),
        ),
        textTheme: ThemeData.light().textTheme.copyWith(
            headline6: TextStyle(
                fontFamily: 'OpenSans',
                fontSize: 18,
                fontWeight: FontWeight.bold),
            subtitle1: TextStyle(color: Colors.black54)),
        primarySwatch: Colors.purple,
        accentColor: Colors.amber,
        fontFamily: 'Quicksand',
        // textTheme: TextTheme(
        //     headline1: TextStyle(
        //         fontSize: 20,
        //         fontWeight: FontWeight.bold,
        //         color: Colors.purple),
        //     headline2: TextStyle(
        //         fontSize: 16,
        //         fontWeight: FontWeight.bold,
        //         color: Colors.black87)),
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
    Transaction(id: 't1', amount: 10, title: 'New Shoes', date: DateTime.now()),
    Transaction(
        id: 't2', amount: 20.9, title: 'New Shirt', date: DateTime.now())
  ];
  bool showChart = false;
  List<Transaction> get recentTransaction {
    return transactions.where((element) {
      return element.date.isAfter(DateTime.now().subtract(Duration(days: 7)));
    }).toList();
  }

  void deletor(index) {
    transactions.removeAt(index);
    setState(() {});
  }

  void _addNewTransaction(String title, double amount, DateTime datePicked) {
    transactions.add(Transaction(
        id: DateTime.now().toString(),
        title: title,
        amount: amount,
        date: datePicked));
    setState(() {});
  }

  startAddNewTransaction(BuildContext ctx) {
    showModalBottomSheet(
        isScrollControlled: true,
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
    final isLandscape =
        MediaQuery.of(context).orientation == Orientation.landscape;

    final PreferredSizeWidget apppBar = Platform.isIOS
        ? CupertinoNavigationBar(
            // backgroundColor: Theme.of(context).primaryColor,
            middle: Text(
              'Personal Expenses',
              // style: TextStyle(color: Colors.black54),
            ),
            trailing: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                CupertinoButton(
                  child: Icon(
                    Icons.add,
                    // color: Colors.white,
                  ),
                  onPressed: () => startAddNewTransaction(context),
                )
              ],
            ),
          )
        : AppBar(
            title: Text('Personal Expenses'),
            actions: [
              IconButton(
                icon: Icon(
                  Icons.add,
                  color: Colors.white,
                ),
                onPressed: () => startAddNewTransaction(context),
              )
            ],
          );
    var listWidget = Container(
      height: (MediaQuery.of(context).size.height -
              apppBar.preferredSize.height -
              MediaQuery.of(context).padding.top) *
          0.7,
      child: TransactionList(
        transactions: transactions,
        deletor: deletor,
      ),
    );
    var _body = SafeArea(
      child: SingleChildScrollView(
        child: Column(
          // crossAxisAlignment: CrossAxisAlignment.stretch,
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            if (isLandscape)
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    'Show Chart',
                    style: Theme.of(context).textTheme.headline6,
                    // style: Theme.of(context).textTheme.subtitle1,
                  ),
                  if (Platform.isAndroid)
                    Switch(
                        value: showChart,
                        onChanged: (value) {
                          setState(() {
                            showChart = value;
                          });
                        }),
                  if (Platform.isIOS)
                    CupertinoSwitch(
                        activeColor: Theme.of(context).primaryColor,
                        value: showChart,
                        onChanged: (value) {
                          setState(() {
                            showChart = value;
                          });
                        })
                ],
              ),
            if (!isLandscape)
              Container(
                  height: (MediaQuery.of(context).size.height -
                          apppBar.preferredSize.height -
                          MediaQuery.of(context).padding.top) *
                      0.3,
                  child: Chart(transaction: recentTransaction)),
            if (!isLandscape) listWidget,
            if (isLandscape)
              showChart
                  ? Container(
                      height: (MediaQuery.of(context).size.height -
                              apppBar.preferredSize.height -
                              MediaQuery.of(context).padding.top) *
                          0.7,
                      child: Chart(transaction: recentTransaction))
                  : listWidget
          ],
        ),
      ),
    );
    return Platform.isIOS
        ? CupertinoPageScaffold(
            child: _body,
            navigationBar: apppBar,
          )
        : Scaffold(
            appBar: apppBar,
            body: _body,

            // This trailing comma makes auto-formatting nicer for build methods.
            floatingActionButton: FloatingActionButton(
              onPressed: () => startAddNewTransaction(context),
              child: Icon(Icons.add),
            ),
            floatingActionButtonLocation:
                FloatingActionButtonLocation.centerDocked,
          );
  }
}
