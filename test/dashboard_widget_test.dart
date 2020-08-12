
import 'package:bytebank/main.dart';
import 'package:bytebank/screens/contatos/dashboard.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  testWidgets("Deve apresentar imagem principal quando dashboard for aberto", (WidgetTester tester) async {
    await tester.pumpWidget(MaterialApp(home: Dashboard()));
    final mainImage = find.byType(Image);
    expect(mainImage, findsOneWidget);
  });
  
  testWidgets("Deve apresentar botão de transferências", (WidgetTester tester) async {
    await tester.pumpWidget(MaterialApp(home: Dashboard()));

    final iconeTransferenciaFeature = find.widgetWithIcon(FeatureItem, Icons.monetization_on);
    expect(iconeTransferenciaFeature, findsWidgets);

    final nameTransferenciaFeature = find.widgetWithText(FeatureItem, "Lista de transferências");
    expect(nameTransferenciaFeature, findsWidgets);
  });
}