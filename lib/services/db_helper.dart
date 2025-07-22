import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';

class DatabaseHelper {
  static final DatabaseHelper instance = DatabaseHelper._instance();
  Database? _db;
  DatabaseHelper._instance();
  final String StudentTable = "Student_table";
  final String SId = "id";
  final String SName = "name";
  final String SAge = "age";
  Future<Database?> get db async {
    _db ??= await _initDb();
    return _db;
  }

  Future<Database> _initDb() async {
    final dbPath = await getDatabasesPath();
    final path = join(dbPath, "student.db");
    return openDatabase(
      path,
      version: 1,
      onCreate: (db, version) async {
        await db.execute('''
    CREATE TABLE $StudentTable (
      $SId INTEGER PRIMARY KEY AUTOINCREMENT,
      $SName TEXT,
      $SAge INTEGER
    )
    ''');
        print("✅ Table $StudentTable created!");
      },
    );
  }

  Future<List<Map<String, dynamic>>> getStudentMapList() async {
    Database? db = await this.db;
    final List<Map<String, dynamic>> result = await db!.query(StudentTable);
    return result;
  }

  Future<int> insertStudent(Map<String, dynamic> student) async {
    Database? db = await this.db;
    final int result = await db!.insert(StudentTable, student);
    return result;
  }

  Future<int> updateStudent(Map<String, dynamic> student) async {
    Database? db = await this.db;
    print("Updating student with ID: ${student[SId]}");
    final int result = await db!.update(
      StudentTable,
      student,
      where: "$SId = ?",
      whereArgs: [student[SId]],
    );
    print("Update result: $result");
    return result;
  }

  Future<int> deleteStudent(int id) async {
    Database? db = await this.db;
    final int result = await db!.delete(
      StudentTable,
      where: "$SId = ?",
      whereArgs: [id],
    );
    return result;
  }
}
