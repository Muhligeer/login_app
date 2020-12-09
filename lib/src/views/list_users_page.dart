import 'package:flutter/material.dart';
import 'package:login_app/src/controllers/cadastro_controller.dart';
import 'package:login_app/src/models/user.dart';

class ListUsersPage extends StatefulWidget {
  @override
  _ListUsersPageState createState() => _ListUsersPageState();
}

class _ListUsersPageState extends State<ListUsersPage> {
  List<User> lista = new List();
  final dbHelper = CadastroController();

  @override
  void initState() {
    super.initState();

    dbHelper.getAllUser().then((value) {
      setState(() {
        value.forEach((element) {
          lista.add(element);
          print(lista);
        });
      });
    }).catchError((error) {
      print(error);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Lista de usuários"),
      ),
      body: Container(
        child: ListView.builder(itemBuilder: (context, i) {
          if (i == lista.length) return null;
          return ListTile(
            title: Text(lista[i].usuario),
            leading: Text('$i'),
          );
        }),
      ),
    );
  }
}
