import 'package:login_app/src/database/database_helper.dart';
import 'package:login_app/src/models/user.dart';

class CadastroController {
  DatabaseHelper connection = new DatabaseHelper();

  Future<int> insert(User user) async {
    var db = await connection.database;
    int resposta = await db.insert("user", user.toMap());

    return resposta;
  }

  Future<User> getLogin(String user, String senha) async {
    var db = await connection.database;
    var resposta = await db.rawQuery(
        "SELECT * FROM user WHERE usuario = '$user' and senha = '$senha'");

    if (resposta.length > 0) {
      return new User.fromMap(resposta.first);
    }

    return Future.error('Usuário ou senha incorretos');
  }

  Future<List<User>> getAllUser() async {
    var dbClient = await connection.database;
    var resposta = await dbClient.query("user");

    List<User> list = resposta.isNotEmpty
        ? resposta.map((c) => User.fromMap(c)).toList()
        : null;

    return list;
  }
}
