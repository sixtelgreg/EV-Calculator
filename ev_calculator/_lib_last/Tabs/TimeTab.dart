import 'package:ev_calculator/EvSetup.dart';
import 'package:ev_calculator/MyEditBox.dart';
import 'package:ev_calculator/MyTextBox.dart';
import 'package:ev_calculator/Pages/SettingsPage.dart';
import 'package:ev_calculator/Tabs/EvCalcTitle.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class TimeTab extends StatefulWidget {
  TimeTab({Key key}) : super(key: key);

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

  @override
  Widget build(BuildContext context) {
    var _cost = evSetup.getElectricityCost; // 0.5
    var _extraPay = evSetup.getExtraPay; // 0.5
    var _acCharger = evSetup.getChargerAC;

    var _consumptionKWKm = _consumptionWKm / 1000.0;
    var _consumptionKW = _consumptionKWKm * _mileage;
    var _consumptionNis = _cost * _consumptionKW + _extraPay;
    var _chargerKw = _acCharger ? evSetup.getAcPower : evSetup.getChargerKWt;

    var _chargeTime = (_consumptionKW * 60.0) / _chargerKw;
    var dt = DateTime(
        0, 1, 1, (_chargeTime ~/ 60.0).toInt(), (_chargeTime % 60).toInt());

    return Scaffold(
      backgroundColor: Theme.of(context).primaryColor,
      body: Container(
        color: Theme.of(context).primaryColor,
        child: ListView(
          children: [
            _buildSeparator(),
            SizedBox(height: 10),
            EvCalcTitle(),
            SizedBox(height: 10),
            _buildSeparator(),
            SizedBox(height: 10),
            MyEditBox.fromInt(
                title: 'Расход [W/km]',
                value: _consumptionWKm,
                onChange: _getConsumption),
            SizedBox(height: 15),
            MyEditBox.fromInt(
                title: 'Километраж [km]',
                value: _mileage,
                onChange: _getMileage),
            SizedBox(height: 10),
            _buildSeparator(),
            SizedBox(height: 5),
            MyTextBox.fromDbl(title: 'Заряд [kW]', value: _consumptionKW),
            MyTextBox.fromDbl(
                title: 'Стоимость [ILS]', value: _consumptionNis, digits: 2),
            MyTextBox(
                title: 'Время зарядки', value: '${DateFormat.Hm().format(dt)}'),
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
}
