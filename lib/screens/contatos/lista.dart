

import 'package:bytebank/database/app_database.dart';
import 'package:bytebank/models/contato.dart';
import 'package:bytebank/screens/contatos/formulario.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class ListaContatos extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Contatos"),
      ),
      body: FutureBuilder(
        future: findAll(),
        builder: (context, snapshot) {
          final List<Contato> contatos = snapshot.data;
          return ListView.builder(
            itemBuilder: (contex, index) {
              final Contato contato = contatos[index];
              return _ContactItem(contato: contato,);
            },
            itemCount: contatos.length,
          );
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.of(context).push(
            MaterialPageRoute(
              builder: (context) => FormularioContatos()
            )
          ).then((contato) => debugPrint(contato.toString()));
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
          style: TextStyle(
              fontSize: 24.0
          ),
        ),
        subtitle: Text(
          contato.account.toString(),
          style: TextStyle(
              fontSize: 16.0
          ),
        ),
      ),
    );
  }

}