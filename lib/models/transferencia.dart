
import 'contato.dart';

class Transferencia {
  final String id;
  final double valor;
  final Contato contato;

  Transferencia(this.id, this.valor, this.contato) : assert(valor > 0);

  Transferencia.fromJson(Map<String, dynamic> json) :
      id = json['id'],
      valor = json['value'],
      contato = Contato.fromJson(json['contact']);

  Map<String, dynamic> toJson() => {
    'id': id,
    'value': valor,
    'contact': contato.toJson()
  };

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is Transferencia &&
          runtimeType == other.runtimeType &&
          valor == other.valor &&
          contato == other.contato;

  @override
  int get hashCode => valor.hashCode ^ contato.hashCode;

  @override
  String toString() {
    return 'Transferencia{id: $id, valor: $valor, contato: $contato}';
  }
}