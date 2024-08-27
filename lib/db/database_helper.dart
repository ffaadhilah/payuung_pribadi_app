import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';

class DatabaseHelper {
  static final DatabaseHelper _instance = DatabaseHelper._internal();
  factory DatabaseHelper() => _instance;

  static Database? _database;

  DatabaseHelper._internal();

  Future<Database> get database async {
    if (_database != null) return _database!;

    _database = await _initDatabase();
    return _database!;
  }

  Future<Database> _initDatabase() async {
    String path = join(await getDatabasesPath(), 'profile_database.db');
    return await openDatabase(
      path,
      version: 4,
      onCreate: (db, version) async {
        await db.execute('''
      CREATE TABLE profile(
        id INTEGER PRIMARY KEY AUTOINCREMENT,
        nama TEXT,
        tanggal_lahir TEXT,
        jenis_kelamin TEXT,
        alamat_email TEXT,
        no_hp TEXT,
        pendidikan TEXT,
        status_pernikahan TEXT,
        alamat TEXT,
        kota TEXT,
        provinsi TEXT,
        kode_pos TEXT,
        lama_bekerja TEXT,
        sumber_pendapatan TEXT,
        pendapatan_kotor_pertahun TEXT,
        nama_bank TEXT,
        cabang_bank TEXT,
        nomor_rekening TEXT,
        nama_pemilik_rekening TEXT,
        nik TEXT,             
        kecamatan TEXT,      
        kelurahan TEXT,        
        ktp_image TEXT
      )
      ''');
      },
      onUpgrade: (db, oldVersion, newVersion) async {
        print("Upgrading database from version $oldVersion to $newVersion");
        if (oldVersion < 4) {
          await db.execute("ALTER TABLE profile ADD COLUMN nik TEXT");
          await db.execute("ALTER TABLE profile ADD COLUMN kecamatan TEXT");
          await db.execute("ALTER TABLE profile ADD COLUMN kelurahan TEXT");
        }
      },
    );
  }

  Future<int> insertProfile(Map<String, dynamic> row) async {
    Database db = await database;
    return await db.insert('profile', row);
  }

  Future<int> updateProfile(Map<String, dynamic> row) async {
    Database db = await database;
    int id = row['id'];
    return await db.update('profile', row, where: 'id = ?', whereArgs: [id]);
  }

  Future<Map<String, dynamic>?> getProfile(int id) async {
    Database db = await database;
    List<Map<String, dynamic>> results =
        await db.query('profile', where: 'id = ?', whereArgs: [id]);

    return results.isNotEmpty ? results.first : null;
  }
}
