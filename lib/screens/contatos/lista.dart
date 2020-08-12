import 'package:bytebank/components/progress.dart';
import 'package:bytebank/models/contato.dart';
import 'package:bytebank/screens/contatos/formulario.dart';
import 'package:bytebank/screens/transferencia/formulario.dart';
import 'package:bytebank/widgets/app_dependencies.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class ListaContatos extends StatefulWidget {
  @override
  _ListaContatosState createState() => _ListaContatosState();
}

class _ListaContatosState extends State<ListaContatos> {
  @override
  Widget build(BuildContext context) {
    final dependencies = AppDependencies.of(context);
    return Scaffold(
      appBar: AppBar(
        title: Text("Transferir"),
      ),
      body: FutureBuilder<List<Contato>>(
        initialData: List(),
        future: dependencies.contatoDao.findAll(),
        builder: (context, snapshot) {
          switch (snapshot.connectionState) {
            case ConnectionState.none:
              break;
            case ConnectionState.waiting:
              return Progress();
              break;
            case ConnectionState.active:
              break;
            case ConnectionState.done:
              final List<Contato> contatos = snapshot.data;
              return ListView.builder(
                itemBuilder: (contex, index) {
                  final Contato contato = contatos[index];
                  return ContactItem(
                    contato,
                    onClick: () {
                      Navigator.of(context).push(MaterialPageRoute(
                          builder: (context) =>
                              FormularioTransferencia(contato)));
                    },
                  );
                },
                itemCount: contatos.length,
              );
              break;
          }
          return Text("Unknown error");
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.of(context)
              .push(
                  MaterialPageRoute(builder: (context) => FormularioContatos()))
              .then((value) {
            setState(() {
              widget.createState();
            });
          });
        },
        child: Icon(Icons.add),
      ),
    );
  }
}

class ContactItem extends StatelessWidget {
  final Contato contato;
  final Function onClick;

  const ContactItem(this.contato, {@required this.onClick});

  @override
  Widget build(BuildContext context) {
    return Card(
      child: ListTile(
        onTap: () => onClick(),
        title: Text(
          contato.name,
          style: TextStyle(fontSize: 24.0),
        ),
        subtitle: Text(
          contato.account.toString(),
          style: TextStyle(fontSize: 16.0),
        ),
      ),
    );
  }
}
