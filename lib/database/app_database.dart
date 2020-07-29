import 'package:bytebank/models/contato.dart';
import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';

Future<Database> createDatabase() {
  return getDatabasesPath().then((dbPath){
    final String path = join(dbPath, "bytebank.db");
    return openDatabase(
        path,
        onCreate: (db, version) {
          db.execute("CREATE TABLE contacts("
              "id INTEGER PRIMARY KEY,"
              "name TEXT,"
              "account INTEGER)");
        },
    version: 1);
  });
}

Future<int> save(Contato contato) {
  return createDatabase().then((db) {
    final Map<String, dynamic> contatoMap = Map();

    contatoMap['name'] = contato.name;
    contatoMap['account'] = contato.account;

    return db.insert("contacts", contatoMap);
  });
}

Future<List<Contato>> findAll() {
  return createDatabase().then((db) {
    return db.query("contacts").then((maps) {
      final List<Contato> contatos = List();
      for(Map<String, dynamic> map in maps) {
        final Contato contato = Contato(map['id'], map['name'], map['account']);
        contatos.add(contato);
      }
      return contatos;
    });
  });
}