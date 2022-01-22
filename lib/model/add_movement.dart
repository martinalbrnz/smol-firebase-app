// ignore_for_file: avoid_print

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:intl/intl.dart';

class AddDocument {
  final String description;
  final Timestamp date;
  final String account;
  final num amount;
  AddDocument(this.description, this.account, this.amount, this.date);

  CollectionReference movements =
      FirebaseFirestore.instance.collection('movements');

  Future<void> addMovement() {
    return movements
        .add({'description': description, 'account': account, 'amount': amount})
        .then((value) => print('Movement Added'))
        .catchError((error) => print("failed to add movement: $error"));
  }
}

String convertTimestampToString(Timestamp timestamp) {
  return DateFormat('dd-MM-yy').format(DateTime.fromMicrosecondsSinceEpoch(
      timestamp.microsecondsSinceEpoch)); // SHORT VERSION
}

String amountFormat(num amount) {
  return amount.toStringAsFixed(2);
}
