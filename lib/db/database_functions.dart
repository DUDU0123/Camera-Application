import 'package:camera_app/db/database_creation.dart';
import 'package:camera_app/model/image_model.dart';
import 'package:sqflite/sqflite.dart';

class DbFunctions {
  DataBaseCreation database = DataBaseCreation();

  createData(ImageModel model) async {
    final db = await database.createDB();
    return await db.insert(
      'phototable',
      model.toMap(),
      conflictAlgorithm: ConflictAlgorithm.replace,
    );
  }

  readData() async {
    final db = await database.createDB();
    final value = await db.query('phototable');
    return List.generate(value.length, (index) {
      return ImageModel.fromMap(value[index]);
    });
  }
}
