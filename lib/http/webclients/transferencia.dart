
import 'dart:convert';

import 'package:bytebank/models/transferencia.dart';
import 'package:http/http.dart';

import '../webclient.dart';

class TransferenciaWebClient {
  Future<List<Transferencia>> findAll() async {
    final Response response = await client.get(baseUrl)
        .timeout(Duration(seconds: 5));

    final List<dynamic> transferenciasDecoded = jsonDecode(response.body);

    return transferenciasDecoded.map((dynamic json) =>
        Transferencia.fromJson(json)).toList();
  }

  Future<Transferencia> save(Transferencia transferencia, String password) async {
    String transferenciaJson = jsonEncode(transferencia.toJson());

    final Response response = await client.post(
        baseUrl,
        headers: {
          "Content-Type": "application/json",
          "password": password
        },
        body: transferenciaJson
    );

    if (response.statusCode == 400) {
      throw Exception("Transferencia sem valor");
    }
    if (response.statusCode == 401) {
      throw Exception("Falha na autenticação");
    }

    return Transferencia.fromJson(jsonDecode(response.body));
  }

}