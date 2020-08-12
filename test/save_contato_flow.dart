
import 'package:bytebank/main.dart';
import 'package:bytebank/screens/contatos/dashboard.dart';
import 'package:bytebank/screens/contatos/formulario.dart';
import 'package:bytebank/screens/contatos/lista.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

import 'matchers.dart';
import 'mocks.dart';

void main() {
  testWidgets("deve salvar contato", (tester) async {

    final mockContatoDao = MockContatoDao();

    // Abre app
    await tester.pumpWidget(ByteBankApp(contatoDao: mockContatoDao,));

    // verifica dasboard
    final dashboard = find.byType(Dashboard);
    expect(dashboard, findsOneWidget);

    // verifica botão transferir
    final transferirFeatureItem = find.byWidgetPredicate((widget) {
      return featureItemMatcher(widget, "Transferir", Icons.monetization_on);
    });
    expect(transferirFeatureItem, findsOneWidget);

    // clica no botão
    await tester.tap(transferirFeatureItem);
    await tester.pumpAndSettle();

    // Verifica lista de contatos
    final listaContatos = find.byType(ListaContatos);
    expect(listaContatos, findsOneWidget);

    // encontra botão de novo contato
    final fabNovoContato = find.widgetWithIcon(FloatingActionButton, Icons.add);
    expect(fabNovoContato, findsOneWidget);

    // pressiona botão de novo contato
    await tester.tap(fabNovoContato);
    await tester.pumpAndSettle();

    // Abre formulario de contato
    final formularioContato = find.byType(FormularioContatos);
    expect(formularioContato, findsOneWidget);

  });
}