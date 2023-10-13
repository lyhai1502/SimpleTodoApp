import 'package:flutter/material.dart';
import 'package:todo_list/MyApp.dart';

void main() {
  runApp(MaterialApp(
    home: Scaffold(
        backgroundColor: Color.fromARGB(255, 243, 238, 238),
        appBar: AppBar(title: Text('TO DO LIST')),
        body: MyApp()),
  ));
}
