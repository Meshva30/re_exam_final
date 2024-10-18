
import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';
import '../model/contact_model.dart';


class DatabaseHelper {
  static final DatabaseHelper _instance = DatabaseHelper._internal();
  factory DatabaseHelper() => _instance;
  DatabaseHelper._internal();

  static Database? _database;

  Future<Database> get database async {
    if (_database != null) return _database!;
    _database = await _initDatabase();
    return _database!;
  }

  Future<Database> _initDatabase() async {
    String path = join(await getDatabasesPath(), 'contacts.db');
    return await openDatabase(
      path,
      version: 1,
      onCreate: _onCreate,
    );
  }

  Future<void> _onCreate(Database db, int version) async {
    await db.execute(
      'CREATE TABLE contacts(id INTEGER PRIMARY KEY AUTOINCREMENT, name TEXT, phoneNumber TEXT, email TEXT)',
    );
  }

  Future<int> insertContact(Contact contact) async {
    Database db = await database;
    return await db.insert('contacts', contact.toMap());
  }

  // database_helper.dart
  Future<List<Contact>> getContacts() async {
    Database db = await database;
    final List<Map<String, dynamic>> maps = await db.query('contacts');
    return List.generate(maps.length, (i) {
      return Contact(
        id: maps[i]['id'].toString(),
        name: maps[i]['name'],
        phoneNumber: maps[i]['phoneNumber'],
        email: maps[i]['email'],
      );
    });
  }


  Future<int> updateContact(Contact contact) async {
    Database db = await database;
    return await db.update(
      'contacts',
      contact.toMap(),
      where: 'id = ?',
      whereArgs: [contact.id],
    );
  }

  Future<int> deleteContact(int id) async {
    Database db = await database;
    return await db.delete(
      'contacts',
      where: 'id = ?',
      whereArgs: [id],
    );
  }
}
