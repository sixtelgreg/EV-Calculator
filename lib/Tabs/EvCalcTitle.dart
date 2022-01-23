import 'package:ev_calculator/EvSetup.dart';
import 'package:ev_calculator/Pages/EditCostPage.dart';
import 'package:ev_calculator/Pages/EditChargerPage.dart';
import 'package:flutter/material.dart';

class EvCalcTitle extends StatefulWidget {
  const EvCalcTitle({Key? key}) : super(key: key);

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

  void _costEdit() async {
    await Navigator.of(context).push(
      MaterialPageRoute(
        builder: (context) {
          return EditCostPage();
        },
      ),
    ).then((value) {
      setState(() {});
    });
  }

  @override
  Widget build(BuildContext context) {
    //var _batteryFullPow = evSetup.getBatteryFullPower;
    var _chargerAc = evSetup.getChargerAmp;
    var _chargerDc = evSetup.getChargerKWt;
    var _cost = evSetup.getElectricityCost;
    var _extraPay = evSetup.getExtraPay;
    var _acCharger = evSetup.getChargerAC;
    var _acVoltage = evSetup.getAcVoltage;
    var _acPhases = evSetup.getAcPhases;
    var _acPower = evSetup.getAcPower;

    const double _titleOffset = 0.0;
    const double _iconGap = 5.0;
    const double _iconSize = 48.0;

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
            icon: Icon(Icons.charging_station_outlined, color: Color.fromRGBO(3, 169, 244, 1.0)),
            onPressed: (null),
          ),
          SizedBox(width: _iconGap),
          Text(
            _acCharger ? _acPower.toStringAsFixed(1) : _chargerDc.toString(),
            style: TextStyle(fontSize: 32, color: Colors.amberAccent),
          ),
          Text(
            ' kW',
            style: TextStyle(fontSize: 20, color: Colors.white70),
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
            icon: Icon(_acCharger ? Icons.power : Icons.ev_station, color: _acCharger ? Colors.redAccent : Colors.greenAccent),
            onPressed: _chargerEdit,
          ),
          SizedBox(width: _iconGap),
          Text(_acCharger ? _chargerAc.toString() : _chargerDc.toString(), style: TextStyle(fontSize: 32, color: Colors.amberAccent)),
          Text(
            _acCharger ? ' A' : ' kW',
            style: TextStyle(fontSize: 20, color: Colors.white70),
            textAlign: TextAlign.end,
          ),
          SizedBox(width: 15),
          _acCharger
              ? Text(
                  _acPhases.toString() + ' x ' + _acVoltage.toString() + 'v ',
                  style: TextStyle(fontSize: 32, color: Colors.amberAccent),
                )
              : Text(''),
          SizedBox(width: 15),
          Text(
            _acCharger ? 'AC' : 'DC',
            style: TextStyle(fontSize: 20, color: Colors.white70),
          )
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
          Text(_cost.toStringAsFixed(2), style: TextStyle(fontSize: 20, color: Colors.amberAccent)),
          Text(
            ' ILS/kW',
            style: TextStyle(fontSize: 16, color: Colors.white70),
            textAlign: TextAlign.end,
          ),
          SizedBox(width: 15),
          (_extraPay > 0)
              ? Text(
                  'Extra : ',
                  style: TextStyle(fontSize: 20, color: Colors.white70),
                  textAlign: TextAlign.start,
                )
              : Text(''),
          (_extraPay > 0)
              ? Text(
                  _extraPay.toStringAsFixed(2),
                  style: TextStyle(fontSize: 20, color: Colors.amberAccent),
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
