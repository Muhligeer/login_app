import 'dart:async';

import 'package:login_app/src/controllers/cadastro_controller.dart';
import 'package:login_app/src/models/user.dart';

class LoginRequest {
  CadastroController connection = new CadastroController();

  Future<User> getLogin(String usuario, String senha) {
    var result = connection.getLogin(usuario, senha);
    return result;
  }
}
