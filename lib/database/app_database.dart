import 'package:bytebank/models/contato.dart';
import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';

const DATABASE = "bytebank.db";
const TABLE_CONTACTS = "contacts";

Future<Database> getDatabase() async {
  String path = join(await getDatabasesPath(), DATABASE);

  return openDatabase(
        path,
        onCreate: (db, version) {
          db.execute("CREATE TABLE $TABLE_CONTACTS("
              "id INTEGER PRIMARY KEY,"
              "name TEXT,"
              "account INTEGER)");
        },
    version: 1,
    onDowngrade: onDatabaseDowngradeDelete);
}

Future<int> save(Contato contato) async {
  final Database db = await getDatabase();
  final Map<String, dynamic> contatoMap = Map();

  contatoMap['name'] = contato.name;
  contatoMap['account'] = contato.account;

  return db.insert(TABLE_CONTACTS, contatoMap);
}

Future<List<Contato>> findAll() async {
  final Database db = await getDatabase();

  final List<Map<String, dynamic>> result = await db.query(TABLE_CONTACTS);

  final List<Contato> contatos = List();
  for(Map<String, dynamic> row in result) {
        final Contato contato = Contato(
            row['id'],
            row['name'],
            row['account']);
        contatos.add(contato);
  }
  return contatos;
}