import 'package:flutter/material.dart';

void main() => runApp(
  ByteBankApp()
);

class ByteBankApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        body: FormularioTransferencia(),
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
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: TextField(
                decoration: InputDecoration(
                  labelText: "Número da conta",
                  hintText: "0000"
                ),
                style: TextStyle(
                  fontSize: 24.0
                ),
                keyboardType: TextInputType.number,
                controller: _controladorNumeroConta,
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: TextField(
                decoration: InputDecoration(
                    labelText: "Valor",
                    hintText: "00.00",
                    icon: Icon(Icons.monetization_on)
                ),
                style: TextStyle(
                    fontSize: 24.0
                ),
                keyboardType: TextInputType.number,
                controller: _controladorValor,
              ),
            ),
            RaisedButton(
              child: Text("Confirmar"),
              onPressed: () {
                debugPrint("Clicou no confirmar");
                debugPrint(_controladorValor.text);
                final double valor = double.tryParse(_controladorValor.text);
                final int numeroConta = int.tryParse(_controladorNumeroConta.text);
                if (numeroConta != null && valor != null) {
                  final transferencia = Transferencia(valor, numeroConta);
                  debugPrint('$transferencia');
                }
              },
            )
          ],
        )
    );
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