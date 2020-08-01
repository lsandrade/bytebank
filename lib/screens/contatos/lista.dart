import 'package:bytebank/dao/dao_contato.dart';
import 'package:bytebank/database/app_database.dart';
import 'package:bytebank/models/contato.dart';
import 'package:bytebank/screens/contatos/formulario.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class ListaContatos extends StatefulWidget {
  @override
  _ListaContatosState createState() => _ListaContatosState();
}

class _ListaContatosState extends State<ListaContatos> {

  final ContatoDao _contatoDao = ContatoDao();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Transferir"),
      ),
      body: FutureBuilder<List<Contato>>(
        initialData: List(),
        future: Future.delayed(Duration(seconds: 1)).then((value) => _contatoDao.findAll()),
        builder: (context, snapshot) {
          switch (snapshot.connectionState) {
            case ConnectionState.none:
              break;
            case ConnectionState.waiting:
              return Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [CircularProgressIndicator(), Text("Loading")],
                ),
              );
              break;
            case ConnectionState.active:
              break;
            case ConnectionState.done:
              final List<Contato> contatos = snapshot.data;
              return ListView.builder(
                itemBuilder: (contex, index) {
                  final Contato contato = contatos[index];
                  return _ContactItem(
                    contato: contato,
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
          Navigator.of(context).push(
              MaterialPageRoute(builder: (context) => FormularioContatos())
          ).then((value){
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


class _ContactItem extends StatelessWidget {
  final Contato contato;

  const _ContactItem({Key key, this.contato}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
      child: ListTile(
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
