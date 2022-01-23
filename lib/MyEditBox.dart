import 'package:flutter/material.dart';
//typedef NumChanged = void Function(int value);

class MyEditBox extends StatefulWidget {
  final String title;
  final String value;
  //final bool captureEnabled;
  final void Function(double)? onDbl;
  final void Function(int)? onInt;
  //TextEditingController _ctrl;
  //final TextEditingController ctrl;
  //final bool Function() _onTap;

  //MyEditBox({this.capture, this.value, this.onDbl, this.onInt});
  //final _ctrl = TextEditingController();
  //

  @override
  _MyEditBoxState createState() => _MyEditBoxState();

  MyEditBox.fromDbl({required this.title, required double value, int digits = 1, Function(double)? onChange})
      : this.value = value.toStringAsFixed(digits),
        this.onDbl = onChange,
        this.onInt = null {
    //_ctrl?.text = this.value;
  }

  MyEditBox.fromInt({required this.title, required int value, required Function(int) onChange})
      : this.value = value.toString(),
        this.onInt = onChange,
        this.onDbl = null {
    //_ctrl?.text = this.value;
  }

  //static String bubu;
  //final ValueNotifier<String> _value = ValueNotifier<String>(bubu);
  //ValueNotifier<String> get val => _value;
}

class _MyEditBoxState extends State<MyEditBox> {
  //final double _elmH = 50.0;
  //final double _elmW = 200;

  var _ctrl = TextEditingController();
  //bool filled = false;

  @override
  void initState() {
    super.initState();
    //filled = false;
    //widget._ctrl = _ctrl;
    _ctrl.text = widget.value;
    _ctrl.addListener(_inputValueInt);
    _ctrl.addListener(_inputValueDbl);
  }

  @override
  void dispose() {
    // Clean up the controller when the widget is removed from the widget tree.
    // This also removes the _printLatestValue listener.
    _ctrl.dispose();
    super.dispose();
  }

  void _inputValueInt() {
    print("Second text field: ${_ctrl.text}");

    if (_ctrl.text.length >= 1 && null != widget.onInt) {
      var intg = int.tryParse(_ctrl.text);
      if (null != intg) {
        widget.onInt!(intg);
      }
    }
  }

  void _inputValueDbl() {
    print("Second text field: ${_ctrl.text}");

    if (_ctrl.text.length >= 1 && null != widget.onDbl) {
      var dbl = double.tryParse(_ctrl.text);
      if (null != dbl) {
        widget.onDbl!(dbl);
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    // if (_ctrl.text != widget.value) {
    //   _ctrl.text = widget.value;
    // }
    return Container(
      //width: _elmW,
      //height: _elmH + 15.0,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          //SizedBox(width: 20),
          Text(widget.title, style: TextStyle(color: Colors.white70, fontSize: 16, fontWeight: FontWeight.normal)),

          SizedBox(width: 15),
          Container(
            //margin: EdgeInsets.only(top: 30),
            width: 120,
            height: 35,
            child: TextField(
              onTap: () {
                //_ctrl.clear();
                setState(() {});

                // if (null != widget?._onTap){
                //   widget?._onTap();
                // }
              },
              keyboardType: TextInputType.phone,
              textAlign: TextAlign.center,
              textInputAction: TextInputAction.done,
              textAlignVertical: TextAlignVertical(y: -0.6),
              style: TextStyle(color: Colors.red, fontSize: 20, fontWeight: FontWeight.bold),
              enableInteractiveSelection: false,
              enableSuggestions: false,
              autocorrect: false,
              showCursor: true,
              decoration: InputDecoration(
                //icon: Icon(Icons.directions_car),
                filled: true,
                //fillColor: Colors.blue,
                //labelText: "Enter",
                //hintText: widget.capture,

                fillColor: Colors.teal[100],
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(20.0),
                  borderSide: BorderSide(color: Colors.white70),
                ),
              ),
              controller: _ctrl,
            ),
            //decoration: BoxDecoration(
            // border: Border.all(
            // width: 1, color: Colors.white38)),
          ),

          SizedBox(width: 30),
        ],
      ),
    );
  }
}
