import 'package:cloud_firestore/cloud_firestore.dart';

class Movement {
  Movement(
      {required this.account,
      required this.amount,
      required this.description,
      required this.date});

  Movement.fromJson(Map<String, Object?> json)
      : this(
          account: json['account']! as String,
          amount: json['amount']! as num,
          description: json['description']! as String,
          date: json['date']! as DateTime,
        );

  final String account, description;
  final num amount;
  final DateTime date;

  Map<String, Object?> toJson() {
    return {
      'account': account,
      'amount': amount,
      'description': description,
      'date': date
    };
  }
}

final movementsRef =
    FirebaseFirestore.instance.collection('movements').withConverter(
          fromFirestore: (snapshot, _) => Movement.fromJson(snapshot.data()!),
          toFirestore: (movement, _) => movement.toJson(),
        );

Future<void> deleteMovement(movementID) {
  return movementsRef
      .doc(movementID)
      .delete()
      .then((value) => print(movementID))
      .catchError((error) => print("Failed to delete"));
}
