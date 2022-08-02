import 'package:radiao/app/repository/repository.dart';

class FavoriteRepository extends Repository {
  Future<void> add(String stationuuid) async {
    final db = await getDb();

    await db.insert("favorite", {
      "stationuuid": stationuuid,
      "created_at": DateTime.now().millisecondsSinceEpoch,
    });
  }

  Future<void> remove(String stationuuid) async {
    final db = await getDb();
    await db.delete("favorite", where: "stationuuid = ?", whereArgs: [stationuuid]);
  }

  Future<bool> check(String stationuuid) async {
    final db = await getDb();
    final result = await db.query("favorite", where: "stationuuid = ?", whereArgs: [stationuuid]);

    return result.isNotEmpty;
  }
}