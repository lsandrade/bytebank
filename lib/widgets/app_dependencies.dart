
import 'package:bytebank/dao/dao_contato.dart';
import 'package:bytebank/http/webclients/transferencia.dart';
import 'package:flutter/cupertino.dart';

class AppDependencies extends InheritedWidget {

  final ContatoDao contatoDao;
  final TransferenciaWebClient webClient;

  AppDependencies({
    @required this.contatoDao,
    @required this.webClient,
    @required Widget child
  }) : super(child : child);

  static AppDependencies of(BuildContext context) =>
      context.dependOnInheritedWidgetOfExactType<AppDependencies>();

  @override
  bool updateShouldNotify(AppDependencies oldWidget) {
    return contatoDao != oldWidget.contatoDao ||
        webClient != oldWidget.webClient;
  }
}