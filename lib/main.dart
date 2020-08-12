import 'package:bytebank/dao/dao_contato.dart';
import 'package:bytebank/screens/contatos/dashboard.dart';
import 'package:bytebank/widgets/app_dependencies.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(ByteBankApp(contatoDao: ContatoDao()));
}

class ByteBankApp extends StatelessWidget {
  final ContatoDao contatoDao;

  const ByteBankApp({@required this.contatoDao});

  @override
  Widget build(BuildContext context) {
    return AppDependencies(
      contatoDao: contatoDao,
      child: MaterialApp(
        home: Dashboard(),
        theme: ThemeData(
          primaryColor: Colors.green[900],
          accentColor: Colors.blueAccent[700],
          buttonTheme: ButtonThemeData(
            buttonColor: Colors.blueAccent[700],
            textTheme: ButtonTextTheme.primary,
          ),
        ),
      ),
    );
  }
}

