// ignore: file_names
import 'package:flutter/material.dart';

class DonateMedicine extends StatefulWidget {
  const DonateMedicine({super.key});

  @override
  State<DonateMedicine> createState() => _DonateMedicineState();
}

class _DonateMedicineState extends State<DonateMedicine> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Donate Medicine')),
      body: Form(
          child: Container(
        child: Column(children: [
          Padding(padding: EdgeInsets.all(30)),
          Text(
            'Ready to Donate?',
            style: TextStyle(
              fontWeight: FontWeight.bold,
              color: Colors.blue,
            ),
          ),
          Text('donate medecine must meet All these criteria')
        ]),
      )),
    );
  }
}
