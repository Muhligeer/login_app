import 'package:flutter/material.dart';
import 'package:login_app/src/views/login_page.dart';
import 'package:shared_preferences/shared_preferences.dart';

class HomeScreen extends StatefulWidget {
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  signOut() async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    setState(() {
      preferences.setInt("value", null);
      print('trnout');
    });
  }

  var value;
  String usuario;
  getPreferences() async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    setState(() {
      value = preferences.getInt("value");
      usuario = preferences.getString("usuario");
    });
    print(usuario);
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getPreferences();
  }

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      appBar: new AppBar(
        title: new Text("Home"),
        actions: <Widget>[
          IconButton(
            onPressed: () {
              signOut();
              return LoginPage();
            },
            icon: Icon(Icons.logout),
          )
        ],
      ),
      body: new Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          children: [
            new Text("Usuário logado: $usuario"),
            Material(
              borderRadius: BorderRadius.circular(5),
              child: new MaterialButton(
                color: Colors.grey[350],
                onPressed: () {
                  Navigator.of(context).pushNamed('/list');
                },
                child: Text(
                  'Listar users',
                  style: TextStyle(color: Colors.black),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
