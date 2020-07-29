
import 'package:flutter/material.dart';

class Dashboard extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Dashboard'),
      ),
      body: Column(
          children: [
            Image.asset("images/bytebank_logo.png"),
            Container(
              color: Colors.green,
              height: 120,
              width: 100,
              child: Column(
                children: [
                  Icon(Icons.people),
                  Text('Contacts')
                ],
              ),
            )
          ],
      ),
    );
  }
}