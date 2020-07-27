
import 'package:bytebank/components/editor.dart';
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

  final TextEditingController _controladorNumeroConta = TextEditingController();
  final TextEditingController _controladorValor = TextEditingController();

  @override
  State<StatefulWidget> createState() {
    return FormularioTransferenciaState();
  }
}

class FormularioTransferenciaState extends State<FormularioTransferencia> {
  @override
  Widget build(BuildContext context) {

    return Scaffold(
        appBar: AppBar(
            title: Text(_tituloAppBar)
        ),
        body: SingleChildScrollView(
          child: Column(
            children: [
              Editor(
                  controlador: widget._controladorNumeroConta,
                  rotulo: _rotuloNumeroConta,
                  dica: _dicaNumeroConta
              ),
              Editor(
                  controlador: widget._controladorValor,
                  rotulo: _rotuloValor,
                  dica: _dicaValor,
                  icone: Icons.monetization_on
              ),
              RaisedButton(
                child: Text(_textoBotao),
                onPressed: () => _criaTransferencia(context),
              )
            ],
          ),
        )
    );
  }

  void _criaTransferencia(BuildContext context) {
    final double valor = double.tryParse(widget._controladorValor.text);
    final int numeroConta = int.tryParse(widget._controladorNumeroConta.text);
    if (numeroConta != null && valor != null) {
      final transferencia = Transferencia(valor, numeroConta);
      Navigator.pop(context, transferencia);
    }
  }
}