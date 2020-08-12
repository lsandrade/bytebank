import 'package:bytebank/screens/contatos/dashboard.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

import '../matchers/matchers.dart';

void main() {
  testWidgets("Deve apresentar imagem principal quando dashboard for aberto",
      (WidgetTester tester) async {
    await tester.pumpWidget(MaterialApp(home: Dashboard()));
    final mainImage = find.byType(Image);
    expect(mainImage, findsOneWidget);
  });

  testWidgets("Deve apresentar botão de realizar transferencia",
      (WidgetTester tester) async {
    await tester.pumpWidget(MaterialApp(home: Dashboard()));

    final transferirFeatureItem = find.byWidgetPredicate((widget) {
      return featureItemMatcher(widget, "Transferir", Icons.monetization_on);
    });

    expect(transferirFeatureItem, findsOneWidget);
  });

  testWidgets("Deve apresentar botão de lista de transferências",
      (WidgetTester tester) async {
    await tester.pumpWidget(MaterialApp(home: Dashboard()));

    final listaTransferenciasFeatureItem = find.byWidgetPredicate((widget) {
      return featureItemMatcher(
          widget, "Lista de transferências", Icons.description);
    });

    expect(listaTransferenciasFeatureItem, findsOneWidget);
  });
}


