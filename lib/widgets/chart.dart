import 'package:expense_tracker/models/transaction.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class Chart extends StatelessWidget {
  final List<Transaction> transaction;

  const Chart({Key key, this.transaction}) : super(key: key);
  List<Map<String, Object>> get groupedTransactionValues {
    return List.generate(7, (index) {
      final weekDay = DateTime.now().subtract(Duration(days: index));
      var totalSum = 0.0;
      for (var i = 0; i < transaction.length; i++) {
        if (transaction[i].date.day == weekDay.day &&
            transaction[i].date.month == weekDay.month &&
            transaction[i].date.year == weekDay.year) {
          totalSum += transaction[i].amount;
        }
      }
      print(weekDay);
      print(totalSum);
      return {'day': DateFormat.E(weekDay), 'amount': 9.99};
    });
  }

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: EdgeInsets.all(20),
      child: Row(
        children: [],
      ),
    );
  }
}
