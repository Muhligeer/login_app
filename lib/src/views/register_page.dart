import 'package:flutter/material.dart';
import 'package:login_app/src/controllers/cadastro_controller.dart';
import 'package:login_app/src/database/database_helper.dart';
import 'package:login_app/src/models/user.dart';

class RegisterPage extends StatefulWidget {
  RegisterPage({Key key, this.title}) : super(key: key);

  final String title;
  @override
  _RegisterPageState createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
  final _formKey = GlobalKey<FormState>();
  final _user = TextEditingController();
  final _password = TextEditingController();
  final _confirmPassword = TextEditingController();

  final dbHelper = CadastroController();
  bool confirmPass = false;

  @override
  Widget build(BuildContext context) {
    final userField = TextFormField(
      controller: _user,
      validator: _validateUser,
      obscureText: false,
      style: TextStyle(fontFamily: 'Tahoma', fontSize: 14),
      decoration: InputDecoration(
        contentPadding: EdgeInsets.fromLTRB(20, 15, 20, 15),
        labelText: 'Usuário',
        border: OutlineInputBorder(borderRadius: BorderRadius.circular(5)),
      ),
    );

    final passwordField = TextFormField(
      controller: _password,
      validator: _validatePass,
      obscureText: true,
      style: TextStyle(fontFamily: 'Tahoma', fontSize: 14),
      decoration: InputDecoration(
        contentPadding: EdgeInsets.fromLTRB(20, 15, 20, 15),
        labelText: 'Senha',
        border: OutlineInputBorder(borderRadius: BorderRadius.circular(5)),
      ),
    );

    final confirmPasswordField = TextFormField(
      controller: _confirmPassword,
      validator: _validateConfirmPass,
      obscureText: true,
      style: TextStyle(fontFamily: 'Tahoma', fontSize: 14),
      decoration: InputDecoration(
        contentPadding: EdgeInsets.fromLTRB(20, 15, 20, 15),
        labelText: 'Confirmar Senha',
        border: OutlineInputBorder(borderRadius: BorderRadius.circular(5)),
      ),
    );

    final sighUpButton = Material(
      elevation: 5.0,
      borderRadius: BorderRadius.circular(5),
      color: Color(0xFF64B5F6),
      child: MaterialButton(
        minWidth: 200,
        padding: EdgeInsets.fromLTRB(25.0, 20.0, 25.0, 20.0),
        onPressed: () {
          _onClickRegister(context);
        },
        child: Text(
          'Cadastrar',
          textAlign: TextAlign.center,
          style: TextStyle(
            fontFamily: 'Tahoma',
            fontSize: 14,
            color: Colors.white,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
    );

    final loginButton = Material(
      elevation: 5.0,
      borderRadius: BorderRadius.circular(5),
      color: Colors.grey,
      child: MaterialButton(
        minWidth: 200,
        padding: EdgeInsets.fromLTRB(25.0, 20.0, 25.0, 20.0),
        onPressed: () {
          Navigator.of(context).pushReplacementNamed('/login');
        },
        child: Text(
          'Entrar',
          textAlign: TextAlign.center,
          style: TextStyle(
            fontFamily: 'Tahoma',
            fontSize: 14,
            color: Colors.white,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
    );

    return Scaffold(
      appBar: AppBar(
        title: Text('Cadastrar'),
      ),
      body: SingleChildScrollView(
        child: SizedBox(
          height: MediaQuery.of(context).size.height,
          width: MediaQuery.of(context).size.width,
          child: Padding(
            padding: const EdgeInsets.all(20.0),
            child: Form(
              key: _formKey,
              child: ListView(
                children: [
                  userField,
                  SizedBox(height: 20),
                  passwordField,
                  SizedBox(height: 20),
                  confirmPasswordField,
                  SizedBox(height: 20),
                  sighUpButton,
                  SizedBox(height: 20),
                  Text('Já possui uma conta?'),
                  SizedBox(height: 20),
                  loginButton,
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  String _validateUser(String user) {
    if (user.isEmpty) {
      return "Informe o Usuário";
    }
    return null;
  }

  String _validatePass(String pass) {
    if (pass.isEmpty) {
      return "Informe uma senha";
    }
    return null;
  }

  String _validateConfirmPass(String pass) {
    if (pass.isEmpty) {
      return "Confirme sua senha";
    } else if (pass != _password.text) {
      return "As senhas devem ser iguais";
    }
    return null;
  }

  _onClickRegister(BuildContext context) async {
    final user = _user.text;
    final password = _password.text;

    if (!_formKey.currentState.validate()) {
      return;
    }

    User usuario = User(user, password);

    Map<String, dynamic> row = {
      DatabaseHelper.columnUsuario: user,
      DatabaseHelper.columnSenha: password
    };
    final id = await CadastroController().insert(usuario);
    print('linha inserida id: $id');

    print('User: $user Password: $password');
  }
}
