import 'package:flutter/material.dart';
import 'package:login_app/src/views/home_screen.dart';

import 'src/shared/app_view.dart';
import 'src/views/login_page.dart';
import 'src/views/register_page.dart';

void main() => runApp(new MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Entrar',
      initialRoute: '/login',
      routes: {
        '/login': (context) => LoginPage(),
        '/register': (context) => RegisterPage(),
      },
    );
  }
}
