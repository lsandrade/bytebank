import 'package:bytebank/main.dart';
import 'package:bytebank/models/contato.dart';
import 'package:bytebank/screens/contatos/dashboard.dart';
import 'package:bytebank/screens/contatos/formulario.dart';
import 'package:bytebank/screens/contatos/lista.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';

import '../matchers/matchers.dart';
import '../mocks/mocks.dart';

void main() {
  testWidgets("deve salvar contato", (tester) async {
    final mockContatoDao = MockContatoDao();

    // Abre app
    await tester.pumpWidget(ByteBankApp(
      contatoDao: mockContatoDao,
    ));

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

    verify(mockContatoDao.findAll()).called(1);

    // encontra botão de novo contato
    final fabNovoContato = find.widgetWithIcon(FloatingActionButton, Icons.add);
    expect(fabNovoContato, findsOneWidget);

    // pressiona botão de novo contato
    await tester.tap(fabNovoContato);
    await tester.pumpAndSettle();

    // Abre formulario de contato
    final formularioContato = find.byType(FormularioContatos);
    expect(formularioContato, findsOneWidget);

    // Encontra TextField pedindo nome completo do usuário
    final nameTextField = find.byWidgetPredicate((widget) {
      return textFieldMatcher(widget, "Nome completo");
    });
    expect(nameTextField, findsOneWidget);

    // Preenche nome do usuário
    await tester.enterText(nameTextField, "Alex");

    // Encontra TextField pedindo número da conta
    final contaTextField = find.byWidgetPredicate((widget) {
      return textFieldMatcher(widget, "Número da conta");
    });
    expect(contaTextField, findsOneWidget);

    // Preenche número da conta
    await tester.enterText(contaTextField, "1000");

    // Encontra botão de criar contato
    final createButton = find.widgetWithText(RaisedButton, "Criar");
    expect(createButton, findsOneWidget);

    // Pressiona botão de criar contato
    await tester.tap(createButton);
    await tester.pumpAndSettle();

    verify(mockContatoDao.save(Contato(0, 'Alex', 1000)));

    // Retorna para lista de contatos
    final listaContatosBack = find.byType(ListaContatos);
    expect(listaContatosBack, findsOneWidget);

    verify(mockContatoDao.findAll());
  });
}

