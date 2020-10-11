import 'package:ev_calculator/Pages/SettingsPage.dart';
import 'package:ev_calculator/Tabs/EvCalcTitle.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
//import 'package:material_design_icons_flutter/icon_map.dart';
//import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';

import '../EvSetup.dart';
import '../MyEditBox.dart';
import '../MyTextBox.dart';

class EvCalculatorTab extends StatefulWidget {
  //EvCalculatorTab({Key key, this.title}) : super(key: key);

  // This widget is the home page of your application. It is stateful, meaning
  // that it has a State object (defined below) that contains fields that affect
  // how it looks.

  // This class is the configuration for the state. It holds the values (in this
  // case the title) provided by the parent (in this case the App widget) and
  // used by the build method of the State. Fields in a Widget subclass are
  // always marked "final".

  final String title = 'EV';

  @override
  _EvCalculatorTabState createState() => _EvCalculatorTabState();
}

class _EvCalculatorTabState extends State<EvCalculatorTab> {
  var _batteryRemainPow = 10.0; // X
  var _consumptionWKm = 170;
  var _mileage = 100;

  Widget _buildSeparator() {
    return Column(children: [
      Divider(
          height: 4,
          thickness: 1,
          color: Colors.white24,
          indent: 10,
          endIndent: 10),
      Divider(
          height: 4,
          thickness: 1,
          color: Colors.white24,
          indent: 10,
          endIndent: 10),
    ]);
  }

  void _getConsumption(int val) {
    setState(() {
      _consumptionWKm = val;
    });
  }

  void _getMileage(int val) {
    setState(() {
      _mileage = val;
    });
  }

  @override
  Widget build(BuildContext context) {
    var _cost = evSetup.getElectricityCost;
    var _extraPay = evSetup.getExtraPay;
    var _acCharger = evSetup.getChargerAC;
    var _battUsable = evSetup.getBattUsable;

    var _chargerPow = _acCharger ? evSetup.getAcPower : evSetup.getChargerKWt;
    var _consumptionKWKm = _consumptionWKm / 1000.0;
    var _consumptionKW = _consumptionKWKm * _mileage;
    _batteryRemainPow = _battUsable - _consumptionKW;
    var _remainDist = (_batteryRemainPow / _consumptionKWKm).round();
    var _consumptionNis = _cost * _consumptionKW + _extraPay;

    // ~20min additional time for cells balancing
    var _toFullChargeTime = (_consumptionKW * 60.0) / _chargerPow + 20;
    var dt = DateTime(0, 1, 1, (_toFullChargeTime ~/ 60.0).toInt(),
        (_toFullChargeTime % 60).toInt());

    return Scaffold(
      body: Container(
        color: Theme.of(context).primaryColor,
        child: ListView(
          children: [
            _buildSeparator(),
            SizedBox(height: 10),
            EvCalcTitle(),
            SizedBox(height: 10),
            _buildSeparator(),
            MyTextBox.fromDbl(
                title: 'Расход Батареи [kW]', value: _consumptionKW),
            MyTextBox.fromDbl(
                title: 'Расход в Шекелях [ILS]',
                value: _consumptionNis,
                digits: 2),
            _buildSeparator(),
            MyTextBox.fromDbl(
                title: 'Остаток Батареи [kW]', value: _batteryRemainPow),
            MyTextBox.fromInt(title: 'Остаток Пути [km]', value: _remainDist),
            MyTextBox(
                title: 'Время до полной зарядки',
                value: '${DateFormat.Hm().format(dt)}'),
            _buildSeparator(),
            SizedBox(height: 5),
            MyEditBox.fromInt(
                title: 'Расход [W/km]',
                value: _consumptionWKm,
                onChange: _getConsumption),
            SizedBox(height: 5),
            MyEditBox.fromInt(
                title: 'Километраж [km]',
                value: _mileage,
                onChange: _getMileage),
            SizedBox(height: 5),
            _buildSeparator(),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: Colors.blue,
        onPressed: _startSetupPage,
        tooltip: 'Settings',
        child: Icon(Icons.settings),
      ),
    );
  }

  void _startSetupPage() async {
    await Navigator.of(context).push(
      MaterialPageRoute(
        builder: (context) {
          return SettingsPage();
        },
      ),
    ).then((value) {
      setState(() {});
    });
  }
}
