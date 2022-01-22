// ignore_for_file: prefer_const_constructors_in_immutables, prefer_const_constructors, avoid_print

import 'package:flutter/material.dart';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/services.dart';

class AddMovementPage extends StatefulWidget {
  const AddMovementPage({Key? key}) : super(key: key);

  @override
  _AddMovementPageState createState() => _AddMovementPageState();
}

class _AddMovementPageState extends State<AddMovementPage> {
  late TextEditingController _accountController;
  late TextEditingController _amountController;
  late TextEditingController _descriptionController;
  late TextEditingController _dateController;

  DateTime date = DateTime.now();

  @override
  void initState() {
    super.initState();
    _accountController = TextEditingController(text: '');
    _amountController = TextEditingController();
    _descriptionController = TextEditingController(text: '');
    _dateController =
        TextEditingController(text: '${date.day}/${date.month}/${date.year}');
    date;
  }

  CollectionReference movements =
      FirebaseFirestore.instance.collection('movements');

  Future<void> addMovement() {
    return movements
        .add({
          'account': _accountController.text.toUpperCase(),
          'amount': int.parse(_amountController.text),
          'description': _descriptionController.text,
          'date': date
        })
        .then((value) => print('Movement Added'))
        .catchError((onError) => print(onError));
  }

  saveMovement() {
    addMovement();
    setState(() {
      date = DateTime.now();
      _accountController.clear();
      _amountController.clear();
      _descriptionController.clear();
      _dateController.text = '${date.day}/${date.month}/${date.year}';
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Add movements'),
      ),
      body: Center(
        child: Padding(
          padding: EdgeInsets.all(12),
          child: Column(
            children: [
              TextField(
                maxLength: 8,
                controller: _accountController,
                enabled: true,
                decoration: InputDecoration(
                  label: Text('Acount name'),
                  alignLabelWithHint: true,
                  filled: true,
                ),
              ),
              TextField(
                controller: _amountController,
                enabled: true,
                decoration: InputDecoration(
                  label: Text('Enter the amount'),
                  alignLabelWithHint: true,
                  filled: true,
                ),
                keyboardType: TextInputType.number,
                inputFormatters: [
                  FilteringTextInputFormatter.allow(
                      RegExp(r"(-*[\d]*\.?[\d]*)")), // Only numbers
                ],
              ),
              TextField(
                controller: _descriptionController,
                enabled: true,
                decoration: InputDecoration(
                  label: Text('Description'),
                  alignLabelWithHint: true,
                  filled: true,
                ),
              ),
              TextField(
                controller: _dateController,
                readOnly: true,
                enabled: true,
                keyboardType: TextInputType.datetime,
                decoration: InputDecoration(
                  label: Text('Date'),
                  alignLabelWithHint: true,
                  filled: true,
                  suffixIcon: IconButton(
                    onPressed: () {
                      showDatePicker(
                        context: context,
                        initialDate: DateTime.now(),
                        firstDate: DateTime(2020),
                        lastDate: DateTime(DateTime.now().year + 2),
                      ).then(
                        (value) => {
                          setState(() {
                            date = value as DateTime;
                            _dateController.text =
                                '${date.day}/${date.month}/${date.year}';
                          }),
                        },
                      );
                    },
                    icon: Icon(
                      Icons.date_range_outlined,
                      size: 28,
                      color: Theme.of(context).primaryColor,
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        child: const Icon(Icons.save),
        onPressed: () => {
          saveMovement(),
        },
      ),
    );
  }
}
