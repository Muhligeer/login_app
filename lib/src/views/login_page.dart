import 'package:flutter/material.dart';
import 'package:login_app/src/models/user.dart';
import 'package:login_app/src/services/login_response.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'home_screen.dart';

class LoginPage extends StatefulWidget {
  LoginPage({Key key, this.title}) : super(key: key);

  final String title;
  @override
  _LoginPageState createState() => _LoginPageState();
}

enum LoginStatus { notSignIn, signIn }

class _LoginPageState extends State<LoginPage> implements LoginCallBack {
  LoginStatus _loginStatus = LoginStatus.notSignIn;
  BuildContext _ctx;
  final _formKey = GlobalKey<FormState>();
  final _user = TextEditingController();
  final _password = TextEditingController();
  final scaffoldKey = new GlobalKey<ScaffoldState>();
  bool _isLoged = false;

  String user, password = '';

  LoginResponse _response;

  _LoginPageState() {
    _response = new LoginResponse(this);
  }

  void _showSnackBar(String text) {
    scaffoldKey.currentState.showSnackBar(new SnackBar(
      content: new Text(text),
    ));
  }

  var value;
  getPreferences() async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    setState(() {
      value = preferences.getInt("value");

      _loginStatus = value == 1 ? LoginStatus.signIn : LoginStatus.notSignIn;
    });
  }

  signOut() async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    setState(() {
      preferences.setInt("value", null);
      _loginStatus = LoginStatus.notSignIn;
    });
  }

  @override
  void initState() {
    super.initState();
    getPreferences();
  }

  @override
  Widget build(BuildContext context) {
    switch (_loginStatus) {
      case LoginStatus.notSignIn:
        _ctx = context;
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

        final loginButton = Material(
          elevation: 5.0,
          borderRadius: BorderRadius.circular(5),
          color: Color(0xFF64B5F6),
          child: MaterialButton(
            minWidth: 200,
            padding: EdgeInsets.fromLTRB(25.0, 20.0, 25.0, 20.0),
            color: Color(0xFF64B5F6),
            onPressed: () {
              _onClickLogin();
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

        final sighUpButton = Material(
          elevation: 5.0,
          borderRadius: BorderRadius.circular(5),
          color: Colors.grey,
          child: MaterialButton(
            minWidth: 200,
            padding: EdgeInsets.fromLTRB(25.0, 20.0, 25.0, 20.0),
            onPressed: () {
              Navigator.of(context).pushReplacementNamed('/register');
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

        return Scaffold(
          appBar: AppBar(
            title: Text('Entrar'),
          ),
          key: scaffoldKey,
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
          ),
        );
        break;
      case LoginStatus.signIn:
        return HomeScreen(signOut);
        break;
    }
  }

  String _validateUser(String user) {
    if (user.isEmpty) {
      return "Informe o Usuário";
    }
    return null;
  }

  String _validatePass(String pass) {
    if (pass.isEmpty) {
      return "Informe a senha";
    }
    return null;
  }

  _onClickLogin() {
    String user = _user.text;
    String password = _password.text.toString();
    final form = _formKey.currentState;

    if (form.validate()) {
      setState(() {
        _isLoged = true;
        form.save();
        _response.doLogin(user, password);
      });
    }

    print('User: $user Password: $password');
  }

  savePreferences(int value, String usuario, String senha) async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    setState(() {
      preferences.setInt("value", value);
      preferences.setString("usuario", usuario);
      preferences.setString("senha", senha);
    });
  }

  @override
  void onLoginError(String error) {
    _showSnackBar(error);
    setState(() {
      _isLoged = false;
    });
  }

  @override
  void onLoginSuccess(User user) async {
    if (user != null) {
      savePreferences(1, user.usuario, user.senha);
      _loginStatus = LoginStatus.signIn;
    } else {
      // TODO: implement onLoginSuccess
      setState(() {
        _isLoged = false;
      });
    }
  }
}
