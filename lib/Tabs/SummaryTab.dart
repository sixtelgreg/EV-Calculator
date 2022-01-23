import 'package:flutter/material.dart';

class SummaryTab extends StatefulWidget {
  SummaryTab({Key? key}) : super(key: key);

  @override
  _SummaryTabState createState() => _SummaryTabState();
}

class _SummaryTabState extends State<SummaryTab> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).primaryColor,
      body: Container(
        child: Text('Summary'),
      ),
    );
  }
}
