import 'package:cloud_firestore/cloud_firestore.dart';

class Task {
  Task({required this.title, required this.description, required this.done});

  Task.fromJson(Map<String, Object?> json)
      : this(
          title: json['title']! as String,
          description: ['description'] as String,
          done: json['done']! as bool,
        );

  final String title, description;
  final bool done;

  Map<String, Object?> toJson() {
    return {
      'title': title,
      'description': description,
      'done': done,
    };
  }
}

final taskRef = FirebaseFirestore.instance.collection('tasks').withConverter(
      fromFirestore: (snapshot, _) => Task.fromJson(snapshot.data()!),
      toFirestore: (task, _) => task.toJson(),
    );
