import 'package:flutter/material.dart';

void main() => runApp(
  ByteBankApp()
);

class ByteBankApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        body: ListaTransferencias(),
      ),
    );
  }
}

class FormularioTransferencia extends StatelessWidget {

  final TextEditingController _controladorNumeroConta = TextEditingController();
  final TextEditingController _controladorValor = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
            title: Text("Criando Transferencia")
        ),
        body: Column(
          children: [
            Editor(
                controlador: _controladorNumeroConta,
                rotulo: "Número da conta",
                dica: "0000"
            ),
            Editor(
                controlador: _controladorValor,
                rotulo: "Valor",
                dica: "0.00",
                icone: Icons.monetization_on
            ),
            RaisedButton(
              child: Text("Confirmar"),
              onPressed: () => _criaTransferencia(),
            )
          ],
        )
    );
  }

  void _criaTransferencia() {
    final double valor = double.tryParse(_controladorValor.text);
    final int numeroConta = int.tryParse(_controladorNumeroConta.text);
    if (numeroConta != null && valor != null) {
      final transferencia = Transferencia(valor, numeroConta);
      debugPrint('$transferencia');
    }
  }

}

// StatefulWidget: Consegue modificar o conteúdo do Widget
// de maneira dinamica

// Stateless: Não consegue modificar o conteúdo
class ListaTransferencias extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Transferências"),
      ),
      body: Column(
          children: [
            ItemTransferencia(Transferencia(100.0, 1000)),
            ItemTransferencia(Transferencia(200.0, 1001)),
            ItemTransferencia(Transferencia(300.0, 2000))
          ]
      ),
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.add),
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) {
                return FormularioTransferencia();
              }
            )
          );
        },
      ),
    );
  }
}

class Editor extends StatelessWidget {

  final TextEditingController controlador;
  final String rotulo;
  final String dica;
  final IconData icone;

  Editor({this.controlador, this.rotulo, this.dica, this.icone});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: TextField(
        decoration: InputDecoration(
            labelText: rotulo,
            hintText: dica,
            icon: icone != null? Icon(icone) : null
        ),
        style: TextStyle(
            fontSize: 24.0
        ),
        keyboardType: TextInputType.number,
        controller: controlador,
      ),
    );
  }
}


class ItemTransferencia extends StatelessWidget {

  final Transferencia _transferencia;

  ItemTransferencia(this._transferencia);

  @override
  Widget build(BuildContext context) {
    return Card(
      child: ListTile(
        leading: Icon(Icons.monetization_on),
        title: Text(_transferencia.valor.toString()),
        subtitle: Text(_transferencia.numeroConta.toString()),
      ),
    );
  }
}

class Transferencia {
  final double valor;
  final int numeroConta;

  Transferencia(this.valor, this.numeroConta);

  @override
  String toString() {
    return 'Transferencia{valor: $valor, numeroConta: $numeroConta}';
  }
}