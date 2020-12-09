import 'dart:io';

import 'package:path/path.dart';
import 'package:path_provider/path_provider.dart';
import 'package:sqflite/sqflite.dart';

class DatabaseHelper {
  static final _databaseName = "DatabaseLogin.db";
  static final _databaseVersion = 1;

  static final table = 'user';

  static final columnId = 'id';
  static final columnUsuario = 'usuario';
  static final columnSenha = 'senha';

  DatabaseHelper._privateConstructor();
  static final DatabaseHelper instance =
      new DatabaseHelper._privateConstructor();
  factory DatabaseHelper() => instance;

  static Database _database;

  Future<Database> get database async {
    if (_database != null) return _database;
    _database = await _initDatabase();
    return _database;
  }

  _initDatabase() async {
    Directory documentsDirectory = await getApplicationDocumentsDirectory();
    String path = join(documentsDirectory.path, _databaseName);
    return await openDatabase(path,
        version: _databaseVersion, onCreate: _onCreate);
  }

  Future _onCreate(Database db, int version) async {
    await db.execute('''
          CREATE TABLE $table (
            $columnId INTEGER PRIMARY KEY,
            $columnUsuario TEXT NOT NULL,
            $columnSenha INTEGER NOT NULL
          )
          ''');
  }

  //metodos

}
