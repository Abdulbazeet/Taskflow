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
    const textType = 'TEXT';
    const textTypeNotNull = 'TEXT NOT NULL';
    const intType = 'INTEGER';
    const intTypeNotNull = 'INTEGER NOT NULL';

    await db.execute('''
CREATE TABLE habits (
  id $idType,
  habitName $textTypeNotNull,
  frequencyValue $intTypeNotNull,
  frequencyUnit $textTypeNotNull,
  achievedValue $intTypeNotNull,
  startDateTime $intTypeNotNull,
  endTime $intType,                  
  endPeriod $textType,               
  endPeriodValue $intType,           
  reminderHour $intType,             
  reminderMinute $intType,            
  repeatMode $textTypeNotNull,
  repeatPattern $intType,             
  repeatDays $textType                
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

  Future updateHabit(Habits habits) async {
    Database db = await database;
    await db.update(
      'habits',
      habits.toMap(),
      where: 'id = ?',
      whereArgs: [habits.id],
    );
  }

  Future deleteHabit(Habits habits) async {
    Database db = await database;

    await db.delete('habits', where: 'id = ?', whereArgs: [habits.id]);
  }
}
