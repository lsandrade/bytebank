import 'package:bytebank/dao/dao_contato.dart';
import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';

const DATABASE = "bytebank.db";

Future<Database> getDatabase() async {
  String path = join(await getDatabasesPath(), DATABASE);

  return openDatabase(
        path,
        onCreate: (db, version) {
          db.execute(ContatoDao.tableSql);
        },
    version: 1,
    onDowngrade: onDatabaseDowngradeDelete);
}
