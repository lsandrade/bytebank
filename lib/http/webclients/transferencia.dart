import 'dart:convert';

import 'package:bytebank/models/transferencia.dart';
import 'package:http/http.dart';

import '../webclient.dart';

class TransferenciaWebClient {
  static final Map<int, String> _statusCodeResponses = {
    400: "Transferencia sem valor",
    401: "Falha na autenticação"
  };

  Future<List<Transferencia>> findAll() async {
    final Response response =
        await client.get(baseUrl);

    final List<dynamic> transferenciasDecoded = jsonDecode(response.body);

    return transferenciasDecoded
        .map((dynamic json) => Transferencia.fromJson(json))
        .toList();
  }

  Future<Transferencia> save(
      Transferencia transferencia, String password) async {
    String transferenciaJson = jsonEncode(transferencia.toJson());

    final Response response = await client.post(baseUrl,
        headers: {"Content-Type": "application/json", "password": password},
        body: transferenciaJson);

    if (response.statusCode == 200) {
      return Transferencia.fromJson(jsonDecode(response.body));
    }

    throw HttpException(_statusCodeResponses[response.statusCode]);
  }
}

class HttpException implements Exception {
  final String message;
  HttpException(this.message);
}