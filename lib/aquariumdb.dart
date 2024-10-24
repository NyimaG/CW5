import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';

class DatabaseHelper {
  static final DatabaseHelper _instance = DatabaseHelper._internal();
  static Database? _database;

  factory DatabaseHelper() {
    return _instance;
  }

  DatabaseHelper._internal();

  Future<Database> get database async {
    if (_database != null) return _database!;
    _database = await _initDatabase();
    return _database!;
  }

  Future<Database> _initDatabase() async {
    String path = join(await getDatabasesPath(), 'aquarium.db');
    return await openDatabase(
      path,
      version: 1,
      onCreate: (db, version) {
        return db.execute(
          'CREATE TABLE settings(id INTEGER PRIMARY KEY, speed REAL, color TEXT, fishCount INTEGER)',
        );
      },
    );
  }

  Future<void> saveSettings(double speed, String color, int fishCount) async {
    final db = await database;
    await db.insert(
      'settings',
      {
        'speed': speed,
        'color': color,
        'fishCount': fishCount,
      },
      conflictAlgorithm: ConflictAlgorithm.replace,
    );
  }

  Future<Map<String, dynamic>?> loadSettings() async {
    final db = await database;
    final List<Map<String, dynamic>> maps = await db.query('settings');
    if (maps.isNotEmpty) {
      return maps.first;
    }
    return null; // Return null if no settings found
  }
}

























/*import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';
import 'package:path_provider/path_provider.dart';

class DatabaseHelper {
  static const _databaseName = "MyDatabase.db";
  static const _databaseVersion = 1;
  static const table = 'fishtable';
  static const columnId = 'id';
  static const columnfishcount = 'fc';
  static const columnColor = 'color';
  static const columnSpeed = 'speed';
  late Database _db;
// this opens the database (and creates it if it doesn't exist)
  Future<void> init() async {
    final documentsDirectory = await getApplicationDocumentsDirectory();
    final path = join(documentsDirectory.path, _databaseName);
    _db = await openDatabase(
      path,
      version: _databaseVersion,
      onCreate: _onCreate,
    );
  }

// SQL code to create the database table
  Future _onCreate(Database db, int version) async {
    await db.execute('''
CREATE TABLE $fishtable (
$columnId INTEGER PRIMARY KEY,
$columnfishcount INTEGER NOT NULL,
$columnColor TEXT NOT NULL,
$columnSpeed INTEGER NOT NULL
)
''');
  }

  Future<int> insert(Map<String, dynamic> row) async {
    return await _db.insert(table, row);
  }

  Future<void> _saveSettings() async {
    final db = await openDatabase('settings.db');
    await database.insert('settings', {
      'fc': fishList.length,
      'speed': selectedSpeed,
      'color': selectedColor.value,
    });
  }
}
*/