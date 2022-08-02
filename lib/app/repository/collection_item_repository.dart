import 'package:tune_radio/app/models/station_collection_item.dart';
import 'package:tune_radio/app/repository/repository.dart';

class CollectionItemRepository extends Repository {
  Future<void> create(StationCollectionItem collection) async {
    final db = await getDb();
    await db.insert(StationCollectionItem.tableName, collection.toMap());
  }

  Future<void> update(StationCollectionItem collection) async {
    final db = await getDb();
    await db.update(
      StationCollectionItem.tableName,
      collection.toMap(),
      where: "id = ?",
      whereArgs: [collection.id],
    );
  }

  Future<void> delete(int id) async {
    final db = await getDb();
    await db.delete(
      StationCollectionItem.tableName,
      where: "id = ?",
      whereArgs: [id],
    );
  }

  Future<void> removeStation(String stationuuid) async {
    final db = await getDb();
    await db.delete(
      StationCollectionItem.tableName,
      where: "stationuuid = ?",
      whereArgs: [stationuuid],
    );
  }

  Future<List<StationCollectionItem>?> getByCollection(int collectionId) async {
    final db = await getDb();
    final results = await db.query(
      StationCollectionItem.tableName,
      where: "collection_id = ?",
      whereArgs: [collectionId],
    );

    return results.isNotEmpty
        ? results.map((e) => StationCollectionItem.fromMap(e)).toList()
        : null;
  }

  Future<StationCollectionItem?> get(int id) async {
    final db = await getDb();
    final result = await db.query(
      StationCollectionItem.tableName,
      where: "id = ?",
      whereArgs: [id],
    );

    return result.isNotEmpty
        ? StationCollectionItem.fromMap(result.first)
        : null;
  }

  Future<List<StationCollectionItem>?> getAll() async {
    final db = await getDb();
    final results = await db.query(StationCollectionItem.tableName);
    return results.isNotEmpty
        ? results.map((e) => StationCollectionItem.fromMap(e)).toList()
        : null;
  }
}
