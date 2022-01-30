import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:smolapp/pages/login_page.dart';
import 'package:smolapp/pages/main_page.dart';
import 'pages/accounts_totals_page.dart';
import 'pages/add_movements_page.dart';
import 'pages/movements_list_page.dart';
import 'pages/tasks_list_page.dart';

void main() async {
  // Me aseguro que se hayan cargado los widgets de Firebase
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.amber,
      ),
      routes: {
        '/': (_) => const MainPage(),
        '/login': (_) => const LoginPage(),
        '/movements': (_) => const MovementsListPage(),
        '/movements/total': (_) => const AccountsTotals(),
        '/movements/add': (_) => const AddMovementPage(),
        '/tasks': (_) => const TasksListPage(),
      },
      initialRoute: '/',
    );
  }
}
