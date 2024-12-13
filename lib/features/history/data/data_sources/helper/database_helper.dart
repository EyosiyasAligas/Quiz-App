import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';

class DatabaseHelper {
  static const String dbName = 'quiz_app.db';
  static const String tableHistory = 'history';
  static const String id = 'id';
  static const String quizTitle = 'quiz_title';
  static const String score = 'score';
  static const String type = 'type';
  static const String difficulty = 'difficulty';
  static const String totalQuestions = 'total_questions';
  static const String questions = 'questions';
  static const String completedAt = 'completed_at';

  static Database? _database;

  // Singleton pattern to ensure a single instance of the database.
  static final DatabaseHelper instance = DatabaseHelper._internal();
  DatabaseHelper._internal();

  Future<Database> get database async {
    if (_database != null) return _database!;
    _database = await _initDatabase();
    return _database!;
  }

  Future<Database> _initDatabase() async {
    final String path = join(await getDatabasesPath(), dbName);
    return await openDatabase(
      path,
      version: 1,
      onCreate: _createDb,
    );
  }

  Future<void> _createDb(Database db, int version) async {
    await db.execute('''
      CREATE TABLE $tableHistory (
        $id INTEGER PRIMARY KEY AUTOINCREMENT,
        $quizTitle TEXT,
        $score INTEGER,
        $type TEXT,
        $difficulty TEXT,
        $totalQuestions INTEGER,
        $questions TEXT,
        $completedAt TEXT
      )
    ''');
  }

  Future<void> close() async {
    final db = await instance.database;
    db.close();
  }
}
