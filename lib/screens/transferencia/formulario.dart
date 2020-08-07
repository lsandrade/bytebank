
import 'package:bytebank/components/editor.dart';
import 'package:bytebank/components/transaction_auth_dialog.dart';
import 'package:bytebank/http/webclients/transferencia.dart';
import 'package:bytebank/models/contato.dart';
import 'package:bytebank/models/transferencia.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

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

  @override
  Widget build(BuildContext context) {

    return Scaffold(
        appBar: AppBar(
            title: Text(_tituloAppBar)
        ),
        body: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  widget.contato.name,
                  style: TextStyle(fontSize: 24.0),
                ),
                Padding(
                  padding: const EdgeInsets.only(top: 16.0),
                  child: Text(
                    widget.contato.name,
                    style: TextStyle(fontSize: 32.0, fontWeight: FontWeight.bold),
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
                                  _criaTransferenciaApi(contextDialog, password);
                                },
                              );
                            }
                        );
                      }
                    ),
                  ),
                )
              ],
            ),
          ),
        )
    );
  }

  void _criaTransferenciaApi(BuildContext context, String password) {
    final double valor = double.tryParse(_controladorValor.text);
    final transferenciaCriada = Transferencia(valor, widget.contato);

    _webClient.save(transferenciaCriada, password).then((transferencia) {
      if (transferencia != null) {
        Navigator.pop(context);
      }
    }).catchError((e) {
      print("Deu ruim: $e");
    });
  }
}