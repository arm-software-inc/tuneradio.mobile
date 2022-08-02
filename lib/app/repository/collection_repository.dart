import 'package:tune_radio/app/models/station_collection.dart';
import 'package:tune_radio/app/repository/repository.dart';

class CollectionRepository extends Repository {
  Future<void> create(StationCollection collection) async {
    final db = await getDb();
    await db.insert(StationCollection.tableName, collection.toMap());
  }

  Future<void> update(StationCollection collection) async {
    final db = await getDb();
    await db.update(
      StationCollection.tableName,
      collection.toMap(),
      where: "id = ?",
      whereArgs: [collection.id],
    );
  }

  Future<void> delete(int id) async {
    final db = await getDb();
    await db.delete(
      StationCollection.tableName,
      where: "id = ?",
      whereArgs: [id],
    );
  }

  Future<StationCollection?> get(int id) async {
    final db = await getDb();
    final result = await db.query(
      StationCollection.tableName,
      where: "id = ?",
      whereArgs: [id],
    );

    return result.isNotEmpty ? StationCollection.fromMap(result.first) : null;
  }

  Future<List<StationCollection>?> getAll() async {
    final db = await getDb();
    final results = await db.query(StationCollection.tableName);
    return results.isNotEmpty
        ? results.map((e) => StationCollection.fromMap(e)).toList()
        : null;
  }
}
