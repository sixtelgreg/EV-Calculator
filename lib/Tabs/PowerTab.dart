import 'package:flutter/material.dart';

class PowerTab extends StatefulWidget {
  PowerTab({Key? key}) : super(key: key);

  @override
  _PowerTabState createState() => _PowerTabState();
}

class _PowerTabState extends State<PowerTab> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).primaryColor,
      body: Container(
        child: Text('Calc Power'),
      ),
    );
  }
}
