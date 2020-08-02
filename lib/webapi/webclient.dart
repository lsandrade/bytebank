
import 'dart:convert';

import 'package:bytebank/models/contato.dart';
import 'package:bytebank/models/transferencia.dart';
import 'package:http/http.dart';
import 'package:http_interceptor/http_interceptor.dart';

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

Future<List<Transferencia>> findAll() async {
  final Client client = HttpClientWithInterceptor.build(
      interceptors: [LoggingInterceptor()]
  );
  final Response response = await client.get("http://192.168.15.17:8080/transactions");
  print("FindAll:");
  print(response.body);
  print("================");
  final List<dynamic> decoded = jsonDecode(response.body);
  final List<Transferencia> transferencias = List();
  for (Map<String, dynamic> transferenciaJson in decoded) {
    final Transferencia transferencia = Transferencia(
        transferenciaJson['value'],
          Contato(
              0,
              transferenciaJson['contact']['name'],
              transferenciaJson['contact']['accountNumber']
        )
    );
    transferencias.add(transferencia);
  }
  print(transferencias);
  return transferencias;
}