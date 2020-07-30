
import 'package:bytebank/dao/dao_contato.dart';
import 'package:bytebank/models/contato.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class FormularioContatos extends StatefulWidget {

  @override
  _FormularioContatosState createState() => _FormularioContatosState();
}

class _FormularioContatosState extends State<FormularioContatos> {

  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _accountController = TextEditingController();
  final ContatoDao _contatoDao = ContatoDao();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Novo Contato'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            TextField(
              decoration: InputDecoration(
                labelText: 'Nome completo'
              ),
              style: TextStyle(
                fontSize: 24.0
              ),
              controller: _nameController,
            ),
            Padding(
              padding: const EdgeInsets.only(top: 8.0),
              child: TextField(
                decoration: InputDecoration(
                    labelText: 'Número da conta'
                ),
                style: TextStyle(
                    fontSize: 24.0
                ),
                keyboardType: TextInputType.number,
                controller: _accountController,
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(top: 16.0),
              child: SizedBox(
                width: double.maxFinite,
                child: RaisedButton(
                  child: Text('Criar'),
                  onPressed: () {
                    final String name = _nameController.text;
                    final int account = int.tryParse(_accountController.text);

                    final Contato contato = Contato(0, name, account);
                    _contatoDao.save(contato).then((id) {
                      Navigator.pop(context);
                    });
                  },
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}