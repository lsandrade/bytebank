
import 'package:bytebank/screens/contatos/lista.dart';
import 'package:flutter/material.dart';

class Dashboard extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Dashboard'),
      ),
      body: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Image.asset("images/bytebank_logo.png"),
            ),
            Row(
              children: [
                _FeatureItem("Transferir", Icons.monetization_on),
                _FeatureItem("Lista de transferências", Icons.description),
              ],
            ),
          ],
      ),
    );
  }
}

class _FeatureItem extends StatelessWidget {

  final String _name;
  final IconData _icon;

  const _FeatureItem( this._name, this._icon);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Material(
        color: Theme.of(context).primaryColor,
        child: InkWell(
          onTap: () {
            Navigator.of(context).push(
                MaterialPageRoute(
                    builder: (context) => ListaContatos()
                )
            );
          },
          child: Container(
            padding: EdgeInsets.all(8.0),
            height: 100,
            width: 150,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Icon(
                  _icon,
                  color: Colors.white,
                  size: 24.0,
                ),
                Text(
                  _name,
                  style: TextStyle(
                      color: Colors.white,
                      fontSize: 16.0
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
