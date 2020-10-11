import 'package:ev_calculator/EvSetup.dart';
import 'package:ev_calculator/Pages/EditChargerPage.dart';
import 'package:flutter/material.dart';

class EvCalcTitle extends StatefulWidget {
  const EvCalcTitle({Key key}) : super(key: key);

  @override
  _EvCalcTitleState createState() => _EvCalcTitleState();
}

class _EvCalcTitleState extends State<EvCalcTitle> {
  void _chargerEdit() async {
    await Navigator.of(context).push(
      MaterialPageRoute(
        builder: (context) {
          return EditChargerPage();
        },
      ),
    ).then((value) {
      setState(() {});
    });
  }

  void _carBatteryEdit() {}

  void _costEdit() {}

  @override
  Widget build(BuildContext context) {
    var _batteryFullPow = evSetup.getBatteryFullPower;
    var _chargerAc = evSetup.getChargerAmp;
    var _chargerDc = evSetup.getChargerKWt;
    var _cost = evSetup.getElectricityCost;
    var _extraPay = evSetup.getExtraPay;
    var _acCharger = evSetup.getChargerAC;
    var _acVoltage = evSetup.getAcVoltage;
    var _acPhases = evSetup.getAcPhases;
    var _acPower = evSetup.getAcPower;

    const double _titleOffset = 20.0;
    const double _iconGap = 20.0;
    const double _iconSize = 32.0;

    return Container(
      //constraints: BoxConstraints(minHeight: 200, maxHeight: 210),
      child: Column(children: [
        Row(children: [
          SizedBox(width: _titleOffset),
          // Text(
          //   'Car Battery :  ',
          //   style: TextStyle(fontSize: 16, color: Colors.white70),
          //   textAlign: TextAlign.start,
          // ),
          IconButton(
            iconSize: _iconSize,
            icon: Icon(Icons.battery_charging_full,
                color: Color.fromRGBO(3, 169, 244, 1.0)),
            onPressed: _carBatteryEdit,
          ),
          SizedBox(width: _iconGap),
          Text(
            _batteryFullPow.toStringAsFixed(1),
            style: TextStyle(fontSize: 20, color: Colors.amberAccent),
          ),
          Text(
            ' kW',
            style: TextStyle(fontSize: 16, color: Colors.white70),
            textAlign: TextAlign.end,
          ),
        ]),
        //SizedBox(height: 8),
        Row(children: [
          SizedBox(width: _titleOffset),
          // Text(
          //   'Charger :  ',
          //   style: TextStyle(fontSize: 16, color: Colors.white70),
          //   textAlign: TextAlign.start,
          // ),
          // Text(
          //   _acCharger ? 'AC  ' : 'DC  ',
          //   style: TextStyle(fontSize: 16, color: Colors.white70),
          //   textAlign: TextAlign.start,
          // ),
          IconButton(
            iconSize: _iconSize,
            icon: Icon(_acCharger ? Icons.power : Icons.ev_station,
                color: _acCharger ? Colors.redAccent : Colors.greenAccent),
            onPressed: _chargerEdit,
          ),
          SizedBox(width: _iconGap),
          Text(_acCharger ? _chargerAc.toString() : _chargerDc.toString(),
              style: TextStyle(fontSize: 18, color: Colors.amberAccent)),
          Text(
            _acCharger ? ' A' : ' kW  DC',
            style: TextStyle(fontSize: 16, color: Colors.white70),
            textAlign: TextAlign.end,
          ),
          SizedBox(width: 15),
          _acCharger
              ? Text(
                  _acPhases.toString() + ' x ' + _acVoltage.toString() + 'v ',
                  style: TextStyle(fontSize: 18, color: Colors.amberAccent),
                )
              : Text(''),
          SizedBox(width: 15),
          _acCharger
              ? Text(
                  _acPower.toStringAsFixed(1),
                  style: TextStyle(fontSize: 18, color: Colors.amberAccent),
                )
              : Text(''),
          _acCharger
              ? Text(
                  ' kW  AC',
                  style: TextStyle(fontSize: 18, color: Colors.white70),
                )
              : Text(''),
        ]),
        //SizedBox(height: 8),
        Row(children: [
          SizedBox(width: _titleOffset),
          // Text(
          //   'Price :  ',
          //   style: TextStyle(fontSize: 16, color: Colors.white70),
          //   textAlign: TextAlign.start,
          // ),
          IconButton(
            iconSize: _iconSize,
            icon: Icon(Icons.euro_symbol, color: Colors.white),
            onPressed: _costEdit,
          ),
          SizedBox(width: _iconGap),
          Text(_cost.toStringAsFixed(2),
              style: TextStyle(fontSize: 18, color: Colors.amberAccent)),
          Text(
            ' ILS/kW',
            style: TextStyle(fontSize: 16, color: Colors.white70),
            textAlign: TextAlign.end,
          ),
          SizedBox(width: 15),
          (_extraPay > 0)
              ? Text(
                  'Extra : ',
                  style: TextStyle(fontSize: 16, color: Colors.white70),
                  textAlign: TextAlign.start,
                )
              : Text(''),
          (_extraPay > 0)
              ? Text(
                  _extraPay.toStringAsFixed(2),
                  style: TextStyle(fontSize: 18, color: Colors.amberAccent),
                  textAlign: TextAlign.end,
                )
              : Text(''),
          (_extraPay > 0)
              ? Text(
                  ' ILS',
                  style: TextStyle(fontSize: 16, color: Colors.white70),
                  textAlign: TextAlign.start,
                )
              : Text(''),
        ]),
      ]),
    );
  }
}
