import 'dart:async';

import 'package:bytebank/components/editor.dart';
import 'package:bytebank/components/progress.dart';
import 'package:bytebank/components/response_dialog.dart';
import 'package:bytebank/components/transaction_auth_dialog.dart';
import 'package:bytebank/http/webclients/transferencia.dart';
import 'package:bytebank/models/contato.dart';
import 'package:bytebank/models/transferencia.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:uuid/uuid.dart';

const _tituloAppBar = "Criando Transferencia";
const _rotuloNumeroConta = "Número da conta";
const _dicaNumeroConta = "0000";
const _rotuloValor = "Valor";
const _dicaValor = "0.00";
const _textoBotao = "Confirmar";

class FormularioTransferencia extends StatefulWidget {
  final Contato contato;

  FormularioTransferencia(this.contato);

  @override
  State<StatefulWidget> createState() {
    return FormularioTransferenciaState();
  }
}

class FormularioTransferenciaState extends State<FormularioTransferencia> {
  final TextEditingController _controladorValor = TextEditingController();
  final TransferenciaWebClient _webClient = TransferenciaWebClient();
  final String transferenciaId = Uuid().v4();

  @override
  Widget build(BuildContext context) {
    print("Id da transferencia $transferenciaId");
    return Scaffold(
        appBar: AppBar(title: Text(_tituloAppBar)),
        body: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Visibility(
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Progress(message: "Enviando..."),
                  ),
                  visible: false,
                ),
                Text(
                  widget.contato.name,
                  style: TextStyle(fontSize: 24.0),
                ),
                Padding(
                  padding: const EdgeInsets.only(top: 16.0),
                  child: Text(
                    widget.contato.name,
                    style:
                    TextStyle(fontSize: 32.0, fontWeight: FontWeight.bold),
                  ),
                ),
                Editor(
                  controlador: _controladorValor,
                  rotulo: _rotuloValor,
                  dica: _dicaValor,
//                    icone: Icons.monetization_on
                ),
                Padding(
                  padding: const EdgeInsets.only(top: 16.0),
                  child: SizedBox(
                    width: double.maxFinite,
                    child: RaisedButton(
                        child: Text(_textoBotao),
                        onPressed: () {
                          showDialog(
                              context: context,
                              builder: (contextDialog) {
                                return TransactionAuthDialog(
                                  onConfirm: (String password) {
                                    _criaTransferenciaApi(
                                        context, password, transferenciaId);
                                  },
                                );
                              });
                        }),
                  ),
                )
              ],
            ),
          ),
        ));
  }

  void _criaTransferenciaApi(BuildContext context, String password,
      String id) async {
    final double valor = double.tryParse(_controladorValor.text);
    final transferenciaCriada = Transferencia(id, valor, widget.contato);

    Transferencia transferencia =
    await _envia(transferenciaCriada, password, context);

    if (transferencia != null) {
      await showDialog(
          context: context,
          builder: (contextDialog) {
            return SuccessDialog("Sucesso");
          });
      Navigator.pop(context);
    }
  }

  Future<Transferencia> _envia(Transferencia transferenciaCriada,
      String password, BuildContext context) async {
    Transferencia transferencia =
    await _webClient.save(transferenciaCriada, password).catchError((e) {
      _mostrarMensagemFalha(context, message: e.message);
    }, test: (e) => e is HttpException).catchError((e) {
      _mostrarMensagemFalha(context,
          message: "Timeout ao submeter a transferência");
    }, test: (e) => e is TimeoutException).catchError((e) {
      _mostrarMensagemFalha(context);
    }, test: (e) => e is Exception);
    return transferencia;
  }

  void _mostrarMensagemFalha(BuildContext context,
      {String message = "Erro desconhecido"}) {
    showDialog(
        context: context,
        builder: (contextDialog) {
          return FailureDialog(message);
        });
  }
}
