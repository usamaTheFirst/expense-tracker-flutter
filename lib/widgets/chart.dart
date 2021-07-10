import 'package:expense_tracker/models/transaction.dart';
import 'package:expense_tracker/widgets/chartbar.dart';
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
      // print(DateFormat.E().format(weekDay));
      // print(totalSum);
      return {
        'day': DateFormat.E().format(weekDay).substring(0, 1),
        'amount': totalSum
      };
    }).reversed.toList();
  }

  @override
  Widget build(BuildContext context) {
    // print(groupedTransactionValues);
    return Card(
      margin: EdgeInsets.all(20),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: groupedTransactionValues.map((data) {
          return Flexible(
            fit: FlexFit.tight,
            child: Padding(
              padding: const EdgeInsets.all(10.0),
              child: ChartBar(
                label: data['day'],
                spendingAmount: data['amount'],
                spendindPctoFTOtal:
                    stuff == 0.0 ? 0.0 : (data['amount'] as double) / stuff,
              ),
            ),
          );
        }).toList(),
      ),
    );
  }

  double get totalSpending {
    return groupedTransactionValues.fold(0.0, (sum, item) {
      return sum + item['amount'];
    });
  }

  double get stuff {
    double sum = 0;
    for (var item in groupedTransactionValues) {
      sum = (item['amount'] as double) + sum;
    }
    return sum;
  }
}
