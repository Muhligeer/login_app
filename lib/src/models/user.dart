import 'package:flutter/cupertino.dart';

class User {
  String id;
  String _usuario;
  String _senha;

  User(this._usuario, this._senha);

  User.fromMap(dynamic obj) {
    this._usuario = obj['usuario'];
    this._senha = obj['senha'].toString();
  }

  String get usuario => _usuario;
  String get senha => _senha;

  Map<String, dynamic> toMap() {
    var map = new Map<String, dynamic>();
    map["usuario"] = _usuario;
    map["senha"] = _senha;
    return map;
  }
}
