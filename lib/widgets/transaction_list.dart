import 'package:expense_tracker/models/transaction.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class TransactionList extends StatelessWidget {
  final List<Transaction> transactions;

  const TransactionList({Key key, this.transactions}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 300,
      child: ListView.builder(
        itemCount: transactions.length,
        itemBuilder: (context, index) {
          return Card(
            child: Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Container(
                  margin: EdgeInsets.symmetric(horizontal: 15, vertical: 10),
                  padding: EdgeInsets.all(10),
                  child: Text(
                    '${transactions[index].amount.toStringAsFixed(2)}\$',
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
                      '${transactions[index].title}',
                      style: Theme.of(context).textTheme.headline2,
                    ),
                    Text(
                      DateFormat('yMMMd').format(transactions[index].date),
                      style: TextStyle(color: Colors.grey, fontSize: 14),
                    )
                  ],
                ),
              ],
            ),
          );
        },
        // scrollDirection: Axis.horizontal,
      ),
    );
  }
}
