import 'package:expense_tracker/models/transaction.dart';
import 'package:expense_tracker/widgets/transaction_list.dart';
import 'package:flutter/material.dart';

import 'new_transaction.dart';

class UserTransaction extends StatefulWidget {
  const UserTransaction({Key key}) : super(key: key);

  @override
  _UserTransactionState createState() => _UserTransactionState();
}

class _UserTransactionState extends State<UserTransaction> {
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

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        NewTransaction(
          onPresses: _addNewTransaction,
        ),
        TransactionList(transactions: transactions),
      ],
    );
  }
}
