// SQLite database helper - Mini app usuario

import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';

class DBHelper {
  static Database? _db;

  static Future<Database> get database async {
    if (_db != null) return _db!;

    _db = await initDB();
    return _db!;
  }

  static Future<Database> initDB() async {
    String path = join(await getDatabasesPath(), 'usuarios.db');

    return await openDatabase(
      path,
      version: 1,
      onCreate: (db, version) async {
        await db.execute('''
          CREATE TABLE usuarios(
            id INTEGER PRIMARY KEY AUTOINCREMENT,
            nombre TEXT,
            email TEXT,
            password TEXT
          )
        ''');
      },
    );
  }

  static Future<int> insertUsuario(Map<String, dynamic> usuario) async {
    final db = await database;
    return await db.insert('usuarios', usuario);
  }

  static Future<List<Map<String, dynamic>>> getUltimoUsuario() async {
    final db = await database;
    return await db.query(
      'usuarios',
      orderBy: 'id DESC',
      limit: 1,
    );
  }
}