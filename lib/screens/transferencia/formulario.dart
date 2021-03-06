import 'dart:async';

import 'package:bytebank/components/editor.dart';
import 'package:bytebank/components/progress.dart';
import 'package:bytebank/components/response_dialog.dart';
import 'package:bytebank/components/transaction_auth_dialog.dart';
import 'package:bytebank/http/webclients/transferencia.dart';
import 'package:bytebank/models/contato.dart';
import 'package:bytebank/models/transferencia.dart';
import 'package:bytebank/widgets/app_dependencies.dart';
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

//  final TransferenciaWebClient _webClient = TransferenciaWebClient();
  final String transferenciaId = Uuid().v4();
  bool _sending = false;

  @override
  Widget build(BuildContext context) {
    print("Id da transferencia $transferenciaId");
    final dependencias = AppDependencies.of(context);
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
                  visible: _sending,
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
                                        dependencias.webClient,
                                        context,
                                        password,
                                        transferenciaId);
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

  void _criaTransferenciaApi(TransferenciaWebClient webClient,
      BuildContext context, String password, String id) async {
    _setSending(true);
    final double valor = double.tryParse(_controladorValor.text);
    final transferenciaCriada = Transferencia(id, valor, widget.contato);

    Transferencia transferencia =
        await _envia(webClient, transferenciaCriada, password, context);

    await _mostraMensagemSucesso(transferencia, context);
  }

  void _setSending(sending) {
    setState(() {
      _sending = sending;
    });
  }

  Future _mostraMensagemSucesso(
      Transferencia transferencia, BuildContext context) async {
    if (transferencia != null) {
      await showDialog(
          context: context,
          builder: (contextDialog) {
            return SuccessDialog("Sucesso");
          });
      Navigator.pop(context);
    }
  }

  Future<Transferencia> _envia(
      TransferenciaWebClient webClient,
      Transferencia transferenciaCriada,
      String password,
      BuildContext context) async {

    Transferencia transferencia =
        await webClient.save(transferenciaCriada, password).catchError((e) {
      _mostrarMensagemFalha(context, message: e.message);
    }, test: (e) => e is HttpException).catchError((e) {
      _mostrarMensagemFalha(context,
          message: "Timeout ao submeter a transferência");
    }, test: (e) => e is TimeoutException).catchError((e) {
      _mostrarMensagemFalha(context);
    }, test: (e) => e is Exception).whenComplete(() => _setSending(false));

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
