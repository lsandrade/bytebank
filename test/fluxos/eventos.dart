

import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

import '../matchers/matchers.dart';

Future<void> clickOnTransferirFeatureItem(WidgetTester tester) async{
  // verifica botão transferir
  final transferirFeatureItem = find.byWidgetPredicate((widget) {
    return featureItemMatcher(widget, "Transferir", Icons.monetization_on);
  });
  expect(transferirFeatureItem, findsOneWidget);

  // clica no botão
  return tester.tap(transferirFeatureItem);
}