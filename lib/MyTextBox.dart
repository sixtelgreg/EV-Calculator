import 'package:flutter/material.dart';
//typedef NumChanged = void Function(int value);

class MyTextBox extends StatelessWidget {
  final String title;
  final String value;
  //final bool captureEnabled;
  //final void Function(int) onChanged;
  //final TextEditingController ctrl;

  MyTextBox({required this.title, required this.value});

  MyTextBox.fromDbl({required this.title, required double value, int digits = 1}) : this.value = value.toStringAsFixed(digits);

  MyTextBox.fromInt({required this.title, int? value}) : this.value = value.toString();

  //final double _elmH = 50.0;
  //final double _elmW = 200;
  //final _ctrl = TextEditingController();

  // @override
  // void initState() {
  //   super.initState();

  //   _ctrl.addListener(_inputValue);
  // }

  // @override
  // void dispose() {
  //   // Clean up the controller when the widget is removed from the widget tree.
  //   // This also removes the _printLatestValue listener.
  //   _ctrl.dispose();
  //   super.dispose();
  // }

  // _inputValue() {
  //   print("Second text field: ${_ctrl.text}");
  // }

  @override
  Widget build(BuildContext context) {
    return Container(
      //width: _elmW,
      //height: _elmH + 15.0,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          //SizedBox(width: 20),
          Text(title, style: TextStyle(color: Colors.white70, fontSize: 16, fontWeight: FontWeight.normal)),

          SizedBox(width: 15),
          // Container(
          //   width: 30,
          //   child: TextField(
          //    controller: _ctrl,
          //    ),
          // ),

          Container(
            //width: _elmW,
            //height: _elmH,
            margin: EdgeInsets.all(3),
            child: Center(
                child: Text(value,
                    textAlign: TextAlign.center, style: TextStyle(color: Colors.orangeAccent, fontSize: 30, fontWeight: FontWeight.normal))),
            // decoration: BoxDecoration(
            //   border: Border.all(
            //     width: 1, color: Colors.white38)),
          ),
          SizedBox(width: 30),
        ],
      ),
    );
  }
}
