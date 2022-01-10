import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class MovementCard extends StatelessWidget {
  final String description;
  final Timestamp date;
  final String account;
  final num amount;

  String convertTimestampToString(Timestamp timestamp) {
    // DateTime middle =
    //     DateTime.fromMicrosecondsSinceEpoch(timestamp.microsecondsSinceEpoch);
    // String formattedDate = DateFormat('dd-MM-yy').format(middle);
    //return formattedDate; // LONG VERBOSE VERSION
    return DateFormat('dd-MM-yy').format(DateTime.fromMicrosecondsSinceEpoch(
        timestamp.microsecondsSinceEpoch)); // SHORT VERSION
  }

  String amountFormat(num amount) {
    return amount.toStringAsFixed(2);
  }

  const MovementCard(this.description, this.account, this.amount, this.date,
      {Key? key})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
      color: amount > 0 ? Colors.green[100] : Colors.red[50],
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 12.0),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    Text(
                      convertTimestampToString(date),
                      style: const TextStyle(fontSize: 16),
                    ),
                    Text(
                      account,
                      style: const TextStyle(fontSize: 16),
                    ),
                  ],
                ),
                const SizedBox(
                  height: 12,
                ),
                Text(
                  description,
                  style: const TextStyle(fontSize: 20),
                ),
              ],
            ),
            Text(
              '\$${amountFormat(amount)}',
              style: const TextStyle(fontSize: 20),
            )
          ],
        ),
      ),
    );
  }
}