
import 'dart:convert';

import 'package:bytebank/models/transferencia.dart';
import 'package:http/http.dart';

import '../webclient.dart';

final _headers = { "Content-Type": "application/json", "password": "1000"};

class TransferenciaWebClient {
  Future<List<Transferencia>> findAll() async {
    final Response response = await client.get(baseUrl)
        .timeout(Duration(seconds: 5));

    final List<dynamic> transferenciasDecoded = jsonDecode(response.body);

    return transferenciasDecoded.map((dynamic json) =>
        Transferencia.fromJson(json)).toList();
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

}