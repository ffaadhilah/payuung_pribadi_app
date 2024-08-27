import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';
import 'package:payuung_pribadi_app/models/user_model.dart';

class UserRepository {
  static final UserRepository _instance = UserRepository._internal();
  static Database? _database;

  factory UserRepository() {
    return _instance;
  }

  UserRepository._internal();

  // Get the database, initialize it if it's null
  Future<Database> get database async {
    if (_database != null) return _database!;
    _database = await _initDB();
    return _database!;
  }

  // Initialize the database
  Future<Database> _initDB() async {
    String path = join(await getDatabasesPath(), 'app.db');
    return await openDatabase(
      path,
      onCreate: (db, version) {
        db.execute('''
          CREATE TABLE users(
            id INTEGER PRIMARY KEY AUTOINCREMENT,
            name TEXT,
            birthdate TEXT,
            ktpImagePath TEXT
          )
        ''');
      },
      version: 1,
    );
  }

  // Fetch the user from the database
  Future<User?> getUser() async {
    final db = await database;
    final List<Map<String, dynamic>> maps = await db.query('users');

    if (maps.isNotEmpty) {
      return User.fromMap(maps.first);
    } else {
      return null;
    }
  }

  // Insert or update the user in the database
  Future<void> updateUser(User user) async {
    final db = await database;

    // Check if the user exists
    final existingUser = await getUser();

    if (existingUser == null) {
      await db.insert('users', user.toMap());
    } else {
      await db.update(
        'users',
        user.toMap(),
        where: 'id = ?',
        whereArgs: [user.id],
      );
    }
  }
}
