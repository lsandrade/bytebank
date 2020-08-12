import 'package:bytebank/components/response_dialog.dart';
import 'package:bytebank/components/transaction_auth_dialog.dart';
import 'package:bytebank/main.dart';
import 'package:bytebank/models/contato.dart';
import 'package:bytebank/models/transferencia.dart';
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
    final mockWebclient = MockTransferenciaWebClient();

    // Abre app
    await tester.pumpWidget(ByteBankApp(
      contatoDao: mockContatoDao,
      webClient: mockWebclient,
    ));

    // verifica dasboard
    final dashboard = find.byType(Dashboard);
    expect(dashboard, findsOneWidget);

    final alex = Contato(0, "Alex", 1000);
    when(mockContatoDao.findAll()).thenAnswer((invocation) async => [alex]);

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

    // Verifica nome do usuário
    final nomeContato = find.text("Alex");
    expect(nomeContato, findsWidgets);

    // Verifica widget que pede para digitar o valor
    final textFieldValue = find.byWidgetPredicate((widget) {
      return textFieldMatcher(widget, "Valor");
    });
    expect(textFieldValue, findsOneWidget);

    //Digita valor 199 para transferir
    await tester.enterText(textFieldValue, "199");

    // encontra botão de confirmar
    final transferButton = find.widgetWithText(RaisedButton, "Confirmar");
    expect(transferButton, findsOneWidget);

    // pressiona botao
    await tester.tap(transferButton);
    await tester.pumpAndSettle();

    // verifica apresentação do dialogo de autenticacao
    final transferAuthDialog = find.byType(TransactionAuthDialog);
    expect(transferAuthDialog, findsOneWidget);

    // encontra field do password
    final textFieldPassword =
        find.byKey(transactionAuthDialogTextFieldPassword);
    expect(textFieldPassword, findsOneWidget);

    // Digita senha
    await tester.enterText(textFieldPassword, "1000");

    // Encontra botão de confirmar
    final confirmButton = find.widgetWithText(FlatButton, "Confirma");
    expect(confirmButton, findsOneWidget);

    // Mocka criação da transferencia
    final transferencia = Transferencia(null, 199, alex);
    when(mockWebclient.save(transferencia, "1000"))
        .thenAnswer((_) async => transferencia);

    // Pressiona botão de confirmar
    await tester.tap(confirmButton);
    await tester.pumpAndSettle();

    // Abre dialogo de sucesso
    final successDialog = find.byType(SuccessDialog);
    expect(successDialog, findsOneWidget);

    // encontra botão OK
    final okButton = find.widgetWithText(FlatButton, "Ok");
    expect(okButton, findsOneWidget);

    // pressiona botao
    await tester.tap(okButton);
    await tester.pumpAndSettle();

    // Retorna a lista de contatos
    final contactsListBack = find.byType(ListaContatos);
    expect(contactsListBack, findsOneWidget);

  });
}
