import 'package:bytebank/database/app_database.dart';
import 'package:bytebank/screens/contatos/dashboard.dart';
import 'package:flutter/material.dart';

import 'models/contato.dart';

void main() {
  runApp(ByteBankApp());
  save(Contato(1, "Alex", 1000)).then((id) {
    findAll().then((contatos) {
      debugPrint(contatos.toString());
    });
  });
}

class ByteBankApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Dashboard(),
      theme: ThemeData(
        primaryColor: Colors.green[900],
        accentColor: Colors.blueAccent[700],
        buttonTheme: ButtonThemeData(
          buttonColor: Colors.blueAccent[700],
          textTheme: ButtonTextTheme.primary,
        ),
      ),
    );
  }
}

