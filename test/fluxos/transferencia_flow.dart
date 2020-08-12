
import 'package:bytebank/main.dart';
import 'package:bytebank/models/contato.dart';
import 'package:bytebank/screens/contatos/dashboard.dart';
import 'package:bytebank/screens/contatos/lista.dart';
import 'package:bytebank/screens/transferencia/formulario.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';

import '../matchers/matchers.dart';
import '../mocks/mocks.dart';
import 'eventos.dart';

void main() {
  testWidgets("Deve salvar transferencia", (tester) async {
    final mockContatoDao = MockContatoDao();

    // Abre app
    await tester.pumpWidget(ByteBankApp(
      contatoDao: mockContatoDao,
    ));

    // verifica dasboard
    final dashboard = find.byType(Dashboard);
    expect(dashboard, findsOneWidget);

    when(mockContatoDao.findAll()).thenAnswer((invocation) async {
      return [Contato(0, "Alex", 1000)];
    });

    await clickOnTransferirFeatureItem(tester);
    await tester.pumpAndSettle();

    // Verifica lista de contatos
    final listaContatos = find.byType(ListaContatos);
    expect(listaContatos, findsOneWidget);

    verify(mockContatoDao.findAll()).called(1);

    // Encontra contato
    final itemContato = find.byWidgetPredicate((widget) {
      if (widget is ContactItem) {
        return widget.contato.name == "Alex" && widget.contato.account == 1000;
      }
      return false;
    });
    expect(itemContato, findsOneWidget);

    // Clica no contato
    await tester.tap(itemContato);
    await tester.pumpAndSettle();

    // verifica formulário de transferencia
    final transferenciaForm = find.byType(FormularioTransferencia);
    expect(transferenciaForm, findsOneWidget);

  });
}
