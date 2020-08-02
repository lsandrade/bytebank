
import 'dart:convert';

import 'package:bytebank/models/transferencia.dart';
import 'package:http/http.dart';

import '../webclient.dart';

final _headers = { "Content-Type": "application/json", "password": "1000"};

class TransferenciaWebClient {
  Future<List<Transferencia>> findAll() async {
    final Response response = await client.get(baseUrl)
        .timeout(Duration(seconds: 5));
    List<Transferencia> transferencias = _jsonParaListaTransferencias(response.body);

    return transferencias;
  }

  Future<Transferencia> save(Transferencia transferencia) async {
    String transferenciaJson = jsonEncode(transferencia.toJson());

    final Response response = await client.post(
        baseUrl,
        headers: _headers,
        body: transferenciaJson
    );

    return Transferencia.fromJson(jsonDecode(response.body));
  }

  List<Transferencia> _jsonParaListaTransferencias(String body) {
    final List<dynamic> transferenciasDecoded = jsonDecode(body);
    final List<Transferencia> transferencias = List();

    for (Map<String, dynamic> transferenciaJson in transferenciasDecoded) {
      transferencias.add(Transferencia.fromJson(transferenciaJson));
    }
    return transferencias;
  }
}