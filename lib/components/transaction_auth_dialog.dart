import 'package:flutter/material.dart';

class TransactionAuthDialog extends StatefulWidget {

  final Function(String password) onConfirm;

  const TransactionAuthDialog({
    @required this.onConfirm
  });

  @override
  _TransactionAuthDialogState createState() => _TransactionAuthDialogState();
}

class _TransactionAuthDialogState extends State<TransactionAuthDialog> {

  final TextEditingController _passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Text("Autenticação"),
      content: TextField(
        controller: _passwordController,
        obscureText: true,
        maxLength: 4,
        textAlign: TextAlign.center,
        keyboardType: TextInputType.number,
        decoration: InputDecoration(
          border: OutlineInputBorder()
        ),
        style: TextStyle(
          fontSize: 64,
          letterSpacing: 24
        ),
      ),
      actions: [
        FlatButton(
          onPressed: () => _fecha(context),
          child: Text("Cancelar"),
        ),
        FlatButton(
          child: Text("Confirma"),
          onPressed: () => _confirma(context),
        ),
      ],

    );
  }

  void _confirma(BuildContext context) {
    widget.onConfirm(_passwordController.text);
    _fecha(context);
  }

  void _fecha(BuildContext context) {
    Navigator.pop(context);
  }
}
