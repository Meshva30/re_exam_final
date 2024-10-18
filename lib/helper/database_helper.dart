import 'dart:developer';

import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';

class DbServices {
  static DbServices dbServices = DbServices._();

  DbServices._();

  Database? _database;

  Future<Database?> get database async {
    if (_database != null) return _database;
    _database = await initDatabase();
    return _database;
  }

  Future<Database> initDatabase() async {
    var databasesPath = await getDatabasesPath();
    String path = join(databasesPath, 'demo.db');

    Database data = await openDatabase(path, version: 1,
        onCreate: (Database db, int version) async {
          String query =
          '''CREATE TABLE Contact (id INTEGER PRIMARY KEY AUTOINCREMENT, name TEXT, phoneNumber TEXT, email TEXT)''';
          await db.execute(query);
        });

    return data;
  }


  Future<void> insertDatabase(Map contact)
  async {
    final db = await database;
    List args =[
      contact['name'],
      contact['phoneNumber'],
      contact['email']
    ];
    String query ='INSERT INTO Contact(name, phoneNumber, email) VALUES(?,?,?)';
    db!.rawInsert(query,args);
  }

  Future<List> showDatabase()
  async {
    final db = await database;
    String query ='SELECT * FROM Contact';
    List data =await db!.rawQuery(query);
    log(data.length.toString());
    return data;
  }

  Future<void> deleteContact(int id)
  async {
    final db = await database;
    List args=[
      id
    ];
    String query ='DELETE FROM Contact WHERE id = ?';
    db!.rawDelete(query,args);
  }

  Future<void> updateDatabase(Map contact,int id)
  async {
    final db = await database;
    List args =[
      contact['name'],
      contact['phoneNumber'],
      contact['email'],
      id
    ];
    String query ='UPDATE Contact SET name = ?, phoneNumber = ? ,email =? WHERE id = ?';
    db!.rawUpdate(query,args);
  }
}