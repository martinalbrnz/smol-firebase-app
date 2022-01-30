import 'package:flutter/material.dart';
import 'package:smolapp/model/auth.dart';
import 'package:smolapp/pages/login_page.dart';

class MainPage extends StatelessWidget {
  const MainPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Pagina principal'),
      ),
      body:
          (auth.currentUser != null ? const ActionsList() : const LoginPage()),
    );
  }
}

class ActionsList extends StatefulWidget {
  const ActionsList({
    Key? key,
  }) : super(key: key);

  @override
  State<ActionsList> createState() => _ActionsListState();
}

class _ActionsListState extends State<ActionsList> {
  void _completeSignout() async {
    await Navigator.pushReplacementNamed(context, '/login');
  }

  @override
  Widget build(BuildContext context) {
    if (auth.currentUser == null) {
      _completeSignout();
    }
    return Center(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          TextButton.icon(
            onPressed: () => {Navigator.of(context).pushNamed('/movements')},
            icon: const Icon(Icons.monetization_on),
            label: const Text('Movimientos'),
          ),
          TextButton.icon(
            onPressed: () =>
                {Navigator.of(context).pushNamed('/movements/total')},
            icon: const Icon(Icons.money),
            label: const Text('Totales'),
          ),
          TextButton.icon(
            onPressed: () => {Navigator.of(context).pushNamed('/tasks')},
            icon: const Icon(Icons.task),
            label: const Text('Tareas'),
          ),
          TextButton.icon(
            onPressed: () async {
              await auth.signOut();
              setState(() {});
            },
            icon: const Icon(Icons.task),
            label: const Text('Sign out'),
          ),
        ],
      ),
    );
  }
}
