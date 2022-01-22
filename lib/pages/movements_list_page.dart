import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:smolapp/widgets/movement_card.dart';

class MovementsListPage extends StatelessWidget {
  const MovementsListPage({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const MyHomePage(title: 'Flutter Demo Home Page');
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
        setState(() {
          movimientos.add(doc.data());
        });
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
      floatingActionButton: FloatingActionButton(
        child: const Icon(
          Icons.add,
          size: 40,
        ),
        onPressed: () => {
          Navigator.of(context).pushNamed('/add'),
        },
      ),
    );
  }
}
