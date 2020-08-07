import 'package:flutter/material.dart';

class TransactionAuthDialog extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Text("Autenticação"),
      content: TextField(
        obscureText: true,
        maxLength: 4,
        textAlign: TextAlign.center,
        keyboardType: TextInputType.number,
        decoration: InputDecoration(
          border: OutlineInputBorder()
        ),
        style: TextStyle(
          fontSize: 64,
          letterSpacing: 32
        ),
      ),
      actions: [
        FlatButton(
          onPressed: () => print("Cancel"),
          child: Text("Cancelar"),
        ),
        FlatButton(
          onPressed: () => print("Confirm"),
          child: Text("Confirma"),
        ),
      ],

    );
  }
}
