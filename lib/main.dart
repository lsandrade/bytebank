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

// StatefulWidget: Consegue modificar o conteúdo do Widget
// de maneira dinamica

// Stateless: Não consegue modificar o conteúdo
class ListaTransferencias extends StatefulWidget {

  final List<Transferencia> _transferencias = List();

  @override
  State<StatefulWidget> createState() {
    return ListaTransferenciasState();
  }
}

class ListaTransferenciasState extends State<ListaTransferencias> {

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Transferências"),
      ),
      body: ListView.builder(
        itemCount: widget._transferencias.length,
        itemBuilder: (context, indice) {
          final transferencia = widget._transferencias[indice];
          return ItemTransferencia(transferencia);
        },
      ),
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.add),
        onPressed: () {
          final Future future = Navigator.push(
              context,
              MaterialPageRoute(
                  builder: (context) {
                    return FormularioTransferencia();
                  }
              )
          );
          future.then((transferenciaRecebida) {
            Future.delayed(Duration(seconds: 1), () {
              debugPrint('chegou no then do future');
              debugPrint('$transferenciaRecebida');
              if (transferenciaRecebida != null) {
                setState(() {
                  widget._transferencias.add(transferenciaRecebida);
                });
              }
            });
          });
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