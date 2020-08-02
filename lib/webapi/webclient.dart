import 'dart:convert';

import 'package:bytebank/models/contato.dart';
import 'package:bytebank/models/transferencia.dart';
import 'package:http/http.dart';
import 'package:http_interceptor/http_interceptor.dart';

const String baseUrl = "http://192.168.15.17:8080/transactions";

class LoggingInterceptor implements InterceptorContract {
  @override
  Future<RequestData> interceptRequest({RequestData data}) async {
    print('Request');
    print('url: ${data.url}');
    print('headers: ${data.headers}');
    print('body: ${data.body}');
    print("================");
    return data;
  }

  @override
  Future<ResponseData> interceptResponse({ResponseData data}) async {
    print('Response');
    print('status code: ${data.statusCode}');
    print('headers: ${data.headers}');
    print('body: ${data.body}');
    print("================");
    return data;
  }
}

final Client client =
    HttpClientWithInterceptor.build(interceptors: [LoggingInterceptor()]);

Future<List<Transferencia>> findAll() async {
  final Response response =
      await client.get(baseUrl).timeout(Duration(seconds: 5));
  print("FindAll:");
  print(response.body);
  print("================");
  final List<dynamic> decoded = jsonDecode(response.body);
  final List<Transferencia> transferencias = List();
  for (Map<String, dynamic> transferenciaJson in decoded) {
    final Transferencia transferencia = jsonParaTransferencia(transferenciaJson);
    transferencias.add(transferencia);
  }
  print(transferencias);
  return transferencias;
}

Future<Transferencia> save(Transferencia transferencia) async {
  String transferenciaJson = transferenciaParaJson(transferencia);

  final Response response = await client.post(
      baseUrl,
      headers: {
        "Content-Type": "application/json",
        "password": "1000"
      },
    body: transferenciaJson
  );

  Map<String, dynamic> json = jsonDecode(response.body);
  return jsonParaTransferencia(json);

}

String transferenciaParaJson(Transferencia transferencia) {
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

Transferencia jsonParaTransferencia(Map<String, dynamic> json) {
  return Transferencia(json['value'],
      Contato(0,
          json['contact']['name'],
          json['contact']['accountNumber']
      )
  );
}

