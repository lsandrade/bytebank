
import 'package:bytebank/models/transferencia.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  test("Deve retornar o valor quando criarmos uma transferencia", () {
    final transferencia = Transferencia(null, 200, null);
    expect(transferencia.valor, 200);
  });

  test("Deve dar erro quando criar transferência com valor menor do que zero", () {
    expect(() => Transferencia(null, 0, null), throwsAssertionError);
  });
}