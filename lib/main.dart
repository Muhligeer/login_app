import 'package:flutter/material.dart';
import 'package:login_app/src/login/MyHomePage.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Entrar',
      home: MyHomePage(title: 'Login'),
    );
  }
}
