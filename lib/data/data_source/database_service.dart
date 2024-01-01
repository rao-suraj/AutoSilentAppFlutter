import 'package:auto_silent_app/data/data_source/floor/app_database.dart';

class DatabaseService {
  static final DatabaseService _instance = DatabaseService._internal();
  static AppDatabase? _database;

  DatabaseService._internal();

  factory DatabaseService() => _instance;

  Future<AppDatabase> get getDatabase async {
    if (_database == null) {
      _database =
          await $FloorAppDatabase.databaseBuilder('auto_silent_app.db').build();
      return _database!;
    }
    return _database!;
  }
}
