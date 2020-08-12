
import 'package:bytebank/dao/dao_contato.dart';
import 'package:flutter/cupertino.dart';

class AppDependencies extends InheritedWidget {

  final ContatoDao contatoDao;

  AppDependencies({
    @required this.contatoDao,
    @required Widget child
  }) : super(child : child);

  static AppDependencies of(BuildContext context) =>
      context.dependOnInheritedWidgetOfExactType<AppDependencies>();

  @override
  bool updateShouldNotify(AppDependencies oldWidget) {
    return contatoDao != oldWidget.contatoDao;
  }
}