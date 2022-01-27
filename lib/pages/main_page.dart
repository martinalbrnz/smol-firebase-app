import 'package:flutter/material.dart';

class MainPage extends StatelessWidget {
  const MainPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Main'),
      ),
      body: Center(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            TextButton.icon(
              onPressed: () => {Navigator.of(context).pushNamed('/movements')},
              icon: const Icon(Icons.monetization_on),
              label: const Text('Movimientos'),
            ),
            TextButton.icon(
              onPressed: () => {Navigator.of(context).pushNamed('/tasks')},
              icon: const Icon(Icons.task),
              label: const Text('Tareas'),
            ),
          ],
        ),
      ),
    );
  }
}
