import 'package:sqflite/sqflite.dart';

class SqliteHelper {
  static Database? _db;
  static Future<Database> get databaseInstance async {
    if (_db == null) {
      await setupAndOpenDatabase();
    }
    return _db as Database;
  }

  static Future setupAndOpenDatabase() async {
    final dbPath = await getDatabasesPath();
    _db = await openDatabase(
      "$dbPath/tune_radio.db",
      version: 1,
      onCreate: _create,
      onUpgrade: _upgrade,
    );

    _db?.execute("PRAGMA foreign_keys = ON;");
  }

  static void _create(Database db, int version) async {
    await db.execute("""create table collections (
      id integer primary key,
      name text not null,
      created_at integer not null)
    """);

    await db.execute("""create table collections_items (
      id integer primary key,
      collection_id integer not null,
      stationuuid text not null,
      created_at integer not null,
      foreign key (collection_id) references collections (id)
        ON DELETE CASCADE
        ON UPDATE NO ACTION)
    """);

    await db.execute("""create table history (
      id integer primary key,
      value text not null,
      created_at integer not null)
      """);

    await db.execute(
        "insert into collections (name, created_at) values('Favoritos', ${DateTime.now().millisecondsSinceEpoch})");
  }

  static void _upgrade(Database db, int oldVersion, int newVersion) async {}
}
