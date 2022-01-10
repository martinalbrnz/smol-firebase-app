import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import './widgets/movement_card.dart';

void main() {
  // Me aseguro que se hayan cargado los widgets de Firebase
  WidgetsFlutterBinding.ensureInitialized();
  Firebase.initializeApp().then((value) {
    runApp(const MyApp());
  });
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const MyHomePage(title: 'Flutter Demo Home Page'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({Key? key, required this.title}) : super(key: key);

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  List movimientos = [];

  @override
  void initState() {
    super.initState();
    getMovements();
  }

  void getMovements() async {
    // Primero hacemos referencia a una coleccion
    CollectionReference collectionReference =
        FirebaseFirestore.instance.collection("movements");

    // Nos devuelve de forma asincrona los documentos como lista
    QuerySnapshot movements = await collectionReference.get();
    // Si la cantidad de documentos es distinta de cero, es que cargo algun documento
    if (movements.docs.isNotEmpty) {
      for (var doc in movements.docs) {
        movimientos.add(doc.data());
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Smol app"),
      ),
      body: Center(
        child: ListView.builder(
          itemBuilder: (context, i) {
            return MovementCard(
                movimientos[i]['description'],
                movimientos[i]['account'],
                movimientos[i]['amount'],
                movimientos[i]['date']);
          },
          itemCount: movimientos.length,
        ),
      ),
    );
  }
}
