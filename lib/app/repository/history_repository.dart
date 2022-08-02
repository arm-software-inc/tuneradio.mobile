import 'package:tune_radio/app/models/history.dart';
import 'package:tune_radio/app/repository/repository.dart';

class HistoryRepository extends Repository {
  Future<void> create(History history) async {
    final db = await getDb();
    await db.insert(History.tableName, history.toMap());
  }

  Future<void> delete(int id) async {
    final db = await getDb();
    await db.delete(
      History.tableName,
      where: "id = ?",
      whereArgs: [id],
    );
  }

  Future<List<History>?> getAll() async {
    final db = await getDb();
    final results = await db.query(History.tableName,
        limit: 10, orderBy: "created_at desc");
    return results.isNotEmpty
        ? results.map((e) => History.fromMap(e)).toList()
        : null;
  }
}
