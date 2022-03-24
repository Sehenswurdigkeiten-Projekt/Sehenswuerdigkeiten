import 'package:flutter/material.dart';
import 'package:untitled/loginScreen.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  static const String _title = 'Login';
  // This widget is the root of your application.

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'One Trip',
      home:  Scaffold(
        appBar: AppBar(title: const Text(_title), toolbarHeight: 50,),
        body: const MyLoginWidget(),
      ),
    );
  }
}
