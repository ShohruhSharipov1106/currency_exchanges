import 'package:exam3/screens/page1.dart';
import 'package:exam3/screens/page2.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Exam - 3',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home:  Currency_Exchange_Page1(),
    );
  }
}
