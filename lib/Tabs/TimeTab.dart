import 'package:ev_calculator/EvSetup.dart';
import 'package:ev_calculator/MyEditBox.dart';
import 'package:ev_calculator/MyTextBox.dart';
import 'package:ev_calculator/Pages/EditChargerPage.dart';
import 'package:ev_calculator/Pages/EditCostPage.dart';
//import 'package:ev_calculator/Pages/SettingsPage.dart';
//import 'package:ev_calculator/Tabs/EvCalcTitle.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class TimeTab extends StatefulWidget {
  TimeTab({Key? key}) : super(key: key);

  // init Currency
  final String currencyName = 'NIS';

  @override
  _TimeTabState createState() => _TimeTabState();
}

class _TimeTabState extends State<TimeTab> {
  var _consumptionWKm = 170;
  var _mileage = 100;

  void _getMileage(int val) {
    setState(() {
      _mileage = val;
    });
  }

  void _getConsumption(int val) {
    setState(() {
      _consumptionWKm = val;
    });
  }

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
    var _chargerAc = evSetup.getChargerAmp;
    var _chargerDc = evSetup.getChargerKWt;
    var _cost = evSetup.getElectricityCost;
    var _extraPay = evSetup.getExtraPay;
    var _acCharger = evSetup.getChargerAC;
    var _acVoltage = evSetup.getAcVoltage;
    var _acPhases = evSetup.getAcPhases;
    var _acPower = evSetup.getAcPower;

    const double _titleOffset = 30.0;
    const double _iconGap = 5.0;
    const double _iconSize = 44.0;
    const double _fontLightSize = 24.0;
    const double _fontGraySize = 18.0;

    var _consumptionKWKm = _consumptionWKm / 1000.0;
    var _consumptionKW = _consumptionKWKm * _mileage;
    var _costNis = _cost * _consumptionKW + _extraPay;
    var _chargerKw = _acCharger ? evSetup.getAcPower : evSetup.getChargerKWt;

    var _chargeTime = (_consumptionKW * 60.0) / _chargerKw;
    var dt = DateTime(0, 1, 1, (_chargeTime ~/ 60.0).toInt(), (_chargeTime % 60).toInt());

    return Scaffold(
      backgroundColor: Theme.of(context).primaryColor,
      body: Container(
        color: Theme.of(context).primaryColor,
        child: ListView(
          children: [
            _buildSeparator(),
            SizedBox(height: 10),
            //EvCalcTitle(),
            /////////////////////////////////////////
            Container(
              //constraints: BoxConstraints(minHeight: 200, maxHeight: 210),
              child: Column(children: [
                Row(children: [
                  SizedBox(width: _titleOffset),
                  IconButton(
                    iconSize: _iconSize,
                    icon: Icon(Icons.charging_station_outlined, color: Color.fromRGBO(3, 169, 244, 1.0)),
                    onPressed: (null),
                  ),
                  SizedBox(width: _iconGap),
                  Text(
                    _acCharger ? _acPower.toStringAsFixed(1) : _chargerDc.toString(),
                    style: TextStyle(fontSize: _fontLightSize, color: Colors.amberAccent),
                  ),
                  Text(
                    ' kW',
                    style: TextStyle(fontSize: _fontGraySize, color: Colors.white70),
                    textAlign: TextAlign.end,
                  ),
                ]),
                //SizedBox(height: 8),
                Row(children: [
                  SizedBox(width: _titleOffset),
                  IconButton(
                    iconSize: _iconSize,
                    icon: Icon(_acCharger ? Icons.power : Icons.ev_station, color: _acCharger ? Colors.redAccent : Colors.greenAccent),
                    onPressed: _chargerEdit,
                  ),
                  SizedBox(width: _iconGap),
                  Text(_acCharger ? _chargerAc.toString() : _chargerDc.toString(),
                      style: TextStyle(fontSize: _fontLightSize, color: Colors.amberAccent)),
                  Text(
                    _acCharger ? ' A' : ' kW',
                    style: TextStyle(fontSize: _fontGraySize, color: Colors.white70),
                    textAlign: TextAlign.end,
                  ),
                  SizedBox(width: 15),
                  _acCharger
                      ? Text(
                          _acPhases.toString() + ' x ' + _acVoltage.toString() + 'v ',
                          style: TextStyle(fontSize: _fontLightSize, color: Colors.amberAccent),
                        )
                      : Text(''),
                  SizedBox(width: 10),
                  Text(
                    _acCharger ? 'AC' : 'DC',
                    style: TextStyle(fontSize: _fontLightSize, color: Colors.white70),
                  )
                ]),
                //SizedBox(height: 8),
                Row(children: [
                  SizedBox(width: _titleOffset),
                  IconButton(
                    iconSize: _iconSize,
                    icon: Icon(Icons.attach_money_outlined, color: Colors.green),
                    onPressed: _costEdit,
                  ),
                  SizedBox(width: _iconGap),
                  Text(_cost.toStringAsFixed(2), style: TextStyle(fontSize: _fontLightSize, color: Colors.amberAccent)),
                  Text(
                    ' ILS/kW',
                    style: TextStyle(fontSize: _fontGraySize, color: Colors.white70),
                    textAlign: TextAlign.end,
                  ),
                ]),
                //(_extraPay > 0) ?
                Row(children: [
                  SizedBox(width: _titleOffset + _iconSize + _iconGap + 20),
                  Text(
                    'Extra : ',
                    style: TextStyle(fontSize: _fontGraySize, color: Colors.white70),
                    textAlign: TextAlign.start,
                  ),
                  Text(
                    _extraPay.toStringAsFixed(2),
                    style: TextStyle(fontSize: _fontLightSize, color: Colors.amberAccent),
                    textAlign: TextAlign.end,
                  ),
                  Text(
                    ' ILS',
                    style: TextStyle(fontSize: _fontGraySize, color: Colors.white70),
                    textAlign: TextAlign.start,
                  ),
                ])
                //: null,
              ]),
            ),
            /////////////////////////////////////////
            SizedBox(height: 10),
            _buildSeparator(),
            SizedBox(height: 10),
            MyEditBox.fromInt(title: 'Расход [W/km]', value: _consumptionWKm, onChange: _getConsumption),
            SizedBox(height: 15),
            MyEditBox.fromInt(title: 'Километраж [km]', value: _mileage, onChange: _getMileage),
            SizedBox(height: 10),
            _buildSeparator(),
            SizedBox(height: 5),
            MyTextBox.fromDbl(title: 'Заряд [kW]', value: _consumptionKW),
            MyTextBox.fromDbl(title: 'Стоимость [ILS]', value: _costNis, digits: 2),
            MyTextBox(title: 'Время зарядки', value: '${DateFormat.Hm().format(dt)}'),
            SizedBox(height: 5),
            _buildSeparator(),
          ],
        ),
      ),
      // floatingActionButton: FloatingActionButton(
      //   backgroundColor: Colors.blue,
      //   onPressed: _startSetupPage,
      //   tooltip: 'Settings',
      //   child: Icon(Icons.settings),
      // ),
    );
  }

  // void _startSetupPage() async {
  //   await Navigator.of(context).push(
  //     MaterialPageRoute(
  //       builder: (context) {
  //         return SettingsPage();
  //       },
  //     ),
  //   ).then((value) {
  //     setState(() {});
  //   });
  // }

  Widget _buildSeparator() {
    return Column(children: [
      Divider(height: 4, thickness: 1, color: Colors.white24, indent: 10, endIndent: 10),
      Divider(height: 4, thickness: 1, color: Colors.white24, indent: 10, endIndent: 10),
    ]);
  }
}
