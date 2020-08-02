import 'package:bytebank/models/transferencia.dart';
import 'package:bytebank/screens/contatos/dashboard.dart';
import 'package:bytebank/webapi/webclient.dart';
import 'package:flutter/material.dart';

import 'models/contato.dart';

void main() {
  runApp(ByteBankApp());
}

class ByteBankApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    save(Transferencia(333.0, Contato(0, "Lala", 3000))).then((transf) => print(transf));
    findAll();
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

