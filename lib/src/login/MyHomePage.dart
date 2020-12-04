import 'package:flutter/material.dart';

class MyHomePage extends StatefulWidget {
  MyHomePage({Key key, this.title}) : super(key: key);

  final String title;
  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  @override
  Widget build(BuildContext context) {
    TextEditingController _controller;

    void initState() {
      super.initState();
      _controller = TextEditingController();
    }

    void dispose() {
      _controller.dispose();
      super.dispose();
    }

    final userField = TextField(
      obscureText: false,
      style: TextStyle(fontFamily: 'Tahoma', fontSize: 14),
      decoration: InputDecoration(
          contentPadding: EdgeInsets.fromLTRB(20, 15, 20, 15),
          hintText: 'Usuário',
          border: OutlineInputBorder(borderRadius: BorderRadius.circular(5))),
    );

    final passwordField = TextField(
      obscureText: true,
      style: TextStyle(fontFamily: 'Tahoma', fontSize: 14),
      decoration: InputDecoration(
          contentPadding: EdgeInsets.fromLTRB(20, 15, 20, 15),
          hintText: 'Senha',
          border: OutlineInputBorder(borderRadius: BorderRadius.circular(5))),
    );

    final loginButton = Material(
      elevation: 5.0,
      borderRadius: BorderRadius.circular(5),
      color: Color(0xFF64B5F6),
      child: MaterialButton(
        minWidth: 200,
        padding: EdgeInsets.fromLTRB(25.0, 20.0, 25.0, 20.0),
        onPressed: () {},
        child: Text('Entrar',
            textAlign: TextAlign.center,
            style: TextStyle(
              fontFamily: 'Tahoma',
              fontSize: 14,
              color: Colors.white,
              fontWeight: FontWeight.bold,
            )),
      ),
    );

    final sighUpButton = Material(
      elevation: 5.0,
      borderRadius: BorderRadius.circular(5),
      color: Colors.grey,
      child: MaterialButton(
        minWidth: 200,
        padding: EdgeInsets.fromLTRB(25.0, 20.0, 25.0, 20.0),
        onPressed: () {},
        child: TextField(
            controller: _controller,
            textAlign: TextAlign.center,
            style: TextStyle(
              fontFamily: 'Tahoma',
              fontSize: 14,
              color: Colors.white,
              fontWeight: FontWeight.bold,
            )),
      ),
    );

    return Scaffold(
      body: Center(
        child: Container(
          color: Colors.white,
          child: Padding(
            padding: const EdgeInsets.all(30),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                userField,
                SizedBox(height: 20),
                passwordField,
                SizedBox(height: 20),
                loginButton,
                SizedBox(height: 20),
                Text('Não tem uma conta?'),
                SizedBox(height: 20),
                sighUpButton,
              ],
            ),
          ),
        ),
      ),
    );
  }
}
