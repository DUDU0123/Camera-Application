import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';

class DataBaseCreation {
  Future<Database> createDB() async {
    var db = await openDatabase(
      join(await getDatabasesPath(), 'photodb.db'),
      version: 1,
      onCreate: (Database db, int version) async {
        await db.execute(
            'CREATE TABLE phototable (id INTEGER PRIMARY KEY AUTOINCREMENT, imagepath TEXT)');
      },
      
    );
    return db;
  }

  Future<bool> isDBExist() async {
    bool isDbExist = await databaseExists(
      join(await getDatabasesPath(), 'photodb.db'),
    );

    return isDbExist;
  }
}
