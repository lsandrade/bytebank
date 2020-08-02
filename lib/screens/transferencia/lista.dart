// StatefulWidget: Consegue modificar o conteúdo do Widget
// de maneira dinamica

// Stateless: Não consegue modificar o conteúdo
import 'package:bytebank/components/centered_message.dart';
import 'package:bytebank/components/progress.dart';
import 'package:bytebank/models/transferencia.dart';
import 'package:bytebank/webapi/webclient.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'formulario.dart';

const _tituloAppBar = "Transferências";

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
        title: Text(_tituloAppBar),
      ),
      body: FutureBuilder<List<Transferencia>>(
        future: findAll(),
        builder: (context, snapshot) {
          switch (snapshot.connectionState) {
            case ConnectionState.none:
              break;
            case ConnectionState.waiting:
              return Progress("Carregando");
              break;
            case ConnectionState.active:
              break;
            case ConnectionState.done:
              if(snapshot.hasData) {
                final List<Transferencia> transferencias = snapshot.data;
                if (transferencias.isNotEmpty) {
                  return ListView.builder(
                    itemCount: transferencias.length,
                    itemBuilder: (context, indice) {
                      final transferencia = transferencias[indice];
                      return ItemTransferencia(transferencia);
                    },
                  );
                }
              }
              return CenteredMessage(
                  "Nenhuma transação encontrada",
                  icon: Icons.warning
              );
              break;
          }
          return CenteredMessage("Unknown error");
        },
      ),
//      floatingActionButton: FloatingActionButton(
//        child: Icon(Icons.add),
//        onPressed: () {
//          final Future future =
//              Navigator.push(context, MaterialPageRoute(builder: (context) {
//            return FormularioTransferencia(null);
//          }));
//          future.then(
//              (transferenciaRecebida) => _atualiza(transferenciaRecebida));
//        },
//      ),
    );
  }

  void _atualiza(transferenciaRecebida) {
    if (transferenciaRecebida != null) {
      setState(() {
        widget._transferencias.add(transferenciaRecebida);
      });
    }
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
        subtitle: Text(
            _transferencia.contato.account.toString()
        ),
      ),
    );
  }
}
