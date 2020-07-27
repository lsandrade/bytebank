
import 'package:bytebank/components/editor.dart';
import 'package:bytebank/models/transferencia.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

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
            title: Text("Criando Transferencia")
        ),
        body: SingleChildScrollView(
          child: Column(
            children: [
              Editor(
                  controlador: widget._controladorNumeroConta,
                  rotulo: "Número da conta",
                  dica: "0000"
              ),
              Editor(
                  controlador: widget._controladorValor,
                  rotulo: "Valor",
                  dica: "0.00",
                  icone: Icons.monetization_on
              ),
              RaisedButton(
                child: Text("Confirmar"),
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
      debugPrint("Criando transferencia");
      debugPrint('$transferencia');
      Navigator.pop(context, transferencia);
    }
  }
}