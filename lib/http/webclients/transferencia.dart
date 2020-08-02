
import 'dart:convert';

import 'package:bytebank/models/contato.dart';
import 'package:bytebank/models/transferencia.dart';
import 'package:http/http.dart';

import '../webclient.dart';

class TransferenciaWebClient {
  Future<List<Transferencia>> findAll() async {
    final Response response =
    await client.get(baseUrl).timeout(Duration(seconds: 5));
    final List<dynamic> decoded = jsonDecode(response.body);
    final List<Transferencia> transferencias = List();

    for (Map<String, dynamic> transferenciaJson in decoded) {
      final Transferencia transferencia = _jsonParaTransferencia(
          transferenciaJson);
      transferencias.add(transferencia);
    }

    return transferencias;
  }

  Future<Transferencia> save(Transferencia transferencia) async {
    String transferenciaJson = _transferenciaParaJson(transferencia);

    final Response response = await client.post(
        baseUrl,
        headers: {
          "Content-Type": "application/json",
          "password": "1000"
        },
        body: transferenciaJson
    );

    Map<String, dynamic> json = jsonDecode(response.body);
    return _jsonParaTransferencia(json);
  }

  String _transferenciaParaJson(Transferencia transferencia) {
    final Map<String, dynamic> transferenciaMap = {
      "value": transferencia.valor,
      "contact": {
        "name": transferencia.contato.name,
        "accountNumber": transferencia.contato.account
      }
    };

    final String transferenciaJson = jsonEncode(transferenciaMap);
    return transferenciaJson;
  }

  Transferencia _jsonParaTransferencia(Map<String, dynamic> json) {
    return Transferencia(json['value'],
        Contato(0,
            json['contact']['name'],
            json['contact']['accountNumber']
        )
    );
  }
}