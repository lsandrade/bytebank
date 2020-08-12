import 'package:bytebank/dao/dao_contato.dart';
import 'package:bytebank/http/webclients/transferencia.dart';
import 'package:bytebank/screens/contatos/dashboard.dart';
import 'package:bytebank/widgets/app_dependencies.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(ByteBankApp(
    contatoDao: ContatoDao(),
    webClient: TransferenciaWebClient(),
  ));
}

class ByteBankApp extends StatelessWidget {
  final ContatoDao contatoDao;
  final TransferenciaWebClient webClient;

  const ByteBankApp({@required this.contatoDao, @required this.webClient});

  @override
  Widget build(BuildContext context) {
    return AppDependencies(
      webClient: webClient,
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
