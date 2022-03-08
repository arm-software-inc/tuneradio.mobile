import 'package:radiao/app/helpers/sqlite_helper.dart';
import 'package:sqflite/sqflite.dart';

abstract class Repository {
  Future<Database> getDb() async {
    return await SqliteHelper.databaseInstance;
  }
}