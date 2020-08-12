
import 'package:bytebank/dao/dao_contato.dart';
import 'package:bytebank/http/webclients/transferencia.dart';
import 'package:mockito/mockito.dart';

class MockContatoDao extends Mock implements ContatoDao {}

class MockTransferenciaWebClient extends Mock implements TransferenciaWebClient {}