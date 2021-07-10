import 'package:expense_tracker/models/transaction.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class TransactionList extends StatelessWidget {
  final List<Transaction> transactions;
  final Function deletor;

  const TransactionList({
    Key key,
    this.transactions,
    this.deletor,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 500,
      child: transactions.isEmpty
          ? Column(
              children: [
                Text(
                  'No transactions added yet',
                  style: Theme.of(context).textTheme.headline6,
                ),
                Flexible(
                  // height: 200,
                  // margin: EdgeInsets.all(20),
                  child: Image.asset(
                    'images/waiting.png',
                    fit: BoxFit.cover,
                  ),
                ),
              ],
            )
          : ListView.builder(
              itemCount: transactions.length,
              itemBuilder: (context, index) {
                // return Card(
                //   child: Row(
                //     mainAxisAlignment: MainAxisAlignment.start,
                //     children: [
                //       Container(
                //         margin:
                //             EdgeInsets.symmetric(horizontal: 15, vertical: 10),
                //         padding: EdgeInsets.all(10),
                //         child: Text(
                //           '${transactions[index].amount.toStringAsFixed(2)}\$',
                //           style: Theme.of(context).textTheme.headline6,
                //         ),
                //         decoration: BoxDecoration(
                //           border: Border.all(
                //               color: Theme.of(context).primaryColor, width: 3),
                //           // borderRadius: BorderRadius.circular(10),
                //         ),
                //       ),
                //       // Spacer(),
                //       Column(
                //         crossAxisAlignment: CrossAxisAlignment.start,
                //         children: [
                //           Text(
                //             '${transactions[index].title}',
                //             style: Theme.of(context).textTheme.title,
                //           ),
                //           Text(
                //             DateFormat('yMMMd')
                //                 .format(transactions[index].date),
                //             style: TextStyle(color: Colors.grey, fontSize: 14),
                //           )
                //         ],
                //       ),
                //     ],
                //   ),
                // );
                return Card(
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.all(Radius.circular(20))),
                  elevation: 5,
                  margin: EdgeInsets.symmetric(vertical: 5, horizontal: 10),
                  child: ListTile(
                    // shape: RoundedRectangleBorder(
                    //     borderRadius: BorderRadius.all(Radius.circular(30))),
                    contentPadding: EdgeInsets.symmetric(horizontal: 5),
                    leading: CircleAvatar(
                      radius: 40,
                      child: Padding(
                        padding: const EdgeInsets.all(5.0),
                        child: FittedBox(
                            child: Text(
                                '\$' + transactions[index].amount.toString())),
                      ),
                    ),
                    title: Text(
                      transactions[index].title,
                      style: Theme.of(context).textTheme.headline6,
                    ),
                    subtitle: Text(
                        DateFormat.yMMMd().format(transactions[index].date)),
                    trailing: IconButton(
                      icon: Icon(
                        Icons.delete,
                        color: Theme.of(context).errorColor,
                      ),
                      onPressed: () {
                        ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                            content:
                                Text('${transactions[index].title} deleted')));
                        deletor(index);
                      },
                    ),
                  ),
                );
              },
              // scrollDirection: Axis.horizontal,
            ),
    );
  }
}
