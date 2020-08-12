
import 'package:bytebank/main.dart';
import 'package:bytebank/screens/contatos/dashboard.dart';
import 'package:bytebank/screens/contatos/lista.dart';
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

    await clickOnTransferirFeatureItem(tester);
    await tester.pumpAndSettle();

    // Verifica lista de contatos
    final listaContatos = find.byType(ListaContatos);
    expect(listaContatos, findsOneWidget);

    verify(mockContatoDao.findAll()).called(1);
  });
}
