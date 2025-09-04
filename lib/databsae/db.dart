import 'package:sqflite/sqflite.dart';
import 'package:sqflite/sqlite_api.dart';
import 'package:task_flow/model/habits.dart';

class DatabaseHelper {
  static final DatabaseHelper instance = DatabaseHelper._init();
  static Database? _database;
  DatabaseHelper._init();

  Future<Database> get database async {
    if (_database != null) return _database!;
    _database = await _initDB('habits.db');
    return _database!;
  }

  Future<Database> _initDB(String filePath) async {
    final dbPath = await getDatabasesPath();
    final path = '$dbPath/$filePath';
    return await openDatabase(path, version: 1, onCreate: _createDB);
  }

  Future _createDB(Database db, int version) async {
    const idType = 'INTEGER PRIMARY KEY AUTOINCREMENT';
    const textType = 'TEXT NOT NULL';
    const intType = 'INTEGER NOT NULL';

    await db.execute('''
    CREATE TABLE habits (
      id $idType,
      habitName $textType,
      frequencyValue $intType,
      frequencyUnit $textType,
      achievedValue $intType
    )''');
  }

  Future addHabits(Habits habits) async {
    Database db = await database;
    await db.insert('habits', habits.toMap());
  }

  Future<List<Habits>> getAllHbits() async {
    Database db = await database;
    final habitsMap = await db.query('habits', orderBy: 'id DESC');
    return List.generate(
      habitsMap.length,
      (index) => Habits.fromMap(habitsMap[index]),
    );
  }

  Future updateHabit(Habits habits, int index) async {
    Database db = await database;
    await db.update(
      'habits',
      habits.toMap(),
      where: 'id = ?',
      whereArgs: [index],
    );
  }

  Future deleteHabit(Habits habits, int index) async {
    Database db = await database;
    await db.delete('habits', where: 'id = ?', whereArgs: [index]);
  }
}
