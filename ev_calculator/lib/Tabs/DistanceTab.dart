import 'package:ev_calculator/EvSetup.dart';
import 'package:ev_calculator/MyEditBox.dart';
import 'package:ev_calculator/MyTextBox.dart';
import 'package:ev_calculator/Pages/SettingsPage.dart';
//import 'package:ev_calculator/Tabs/EvCalcTitle.dart';
import 'package:flutter/material.dart';

class DistanceTab extends StatefulWidget {
  DistanceTab({Key key}) : super(key: key);

  @override
  _DistanceTabState createState() => _DistanceTabState();
}

class _DistanceTabState extends State<DistanceTab> {
  //var _batteryFullPow = 10.0; // 44.5
  //var _chargerAc = 16; // 32
  //var // = 55; // 75
  //var _cost = 1.0; // 0.5
  //var _extraPay = 1.0; // 0.5
  //var _acCharger = true;
  //var _acVoltage = 220;
  //var _acPhases = 1;

  var _chargeTime = 60.0; // min
  var _consumptionWKm = 150.0;
  var _mileage = 10;

  @override
  initState() {
    super.initState();
    evSetup.read().then((val) {
      setState(() {
        //_batteryFullPow = evSetup.getBatteryFullPower;
        //_chargerAc = evSetup.getChargerAmp;
        //_chargerDc = evSetup.getChargerKWt;
        //_cost = evSetup.getElectricityCost;
        //_extraPay = evSetup.getExtraPay;
        //_acCharger = evSetup.getChargerAC;
        //_acVoltage = evSetup.getAcVoltage;
        //_acPhases = evSetup.getAcPhases;
      });
    });
  }

  void _getChargeTime(double val) {
    setState(() {
      _chargeTime = val;
    });
  }

  void _getConsumption(double val) {
    setState(() {
      _consumptionWKm = val;
    });
  }

  //int get _chargerKw =>
  //    _acCharger ? _acVoltage * _chargerAc * _acPhases : _chargerDc;

  @override
  Widget build(BuildContext context) {
    //var _consumptionKWKm = _consumptionWKm / 1000.0;
    //var _consumptionKW = _consumptionKWKm * _mileage;
    //var _consumptionNis = _cost * _consumptionKW;

    // 0.22 Kw * A => kW

    //var _chargeTime = (_consumptionKW * 60.0) / _chargerKw;
    //var dt = DateTime(
    //    0, 1, 1, (_chargeTime ~/ 60.0).toInt(), (_chargeTime % 60).toInt());

    return Scaffold(
      backgroundColor: Theme.of(context).primaryColor,
      //appBar: AppBar(
      //title: EvCalcTitle(),
      //centerTitle: true,

      // Row(children: [
      //   Icon(Icons.battery_charging_full, color: Colors.redAccent),
      //   Text(
      //     _batteryFullPow.toStringAsFixed(1),
      //     style: TextStyle(fontSize: 18, color: Colors.white),
      //   ),
      //   Text(
      //     ' kW',
      //     style: TextStyle(fontSize: 14, color: Colors.white70),
      //     textAlign: TextAlign.end,
      //   ),
      //   SizedBox(width: 15),
      //   Icon(Icons.ev_station, color: Colors.greenAccent),
      //   Text(_acCharger ? _chargerAc.toString() : _chargerDc.toString(),
      //       style: TextStyle(fontSize: 18, color: Colors.white)),
      //   Text(
      //     _acCharger ? ' A' : ' kW',
      //     style: TextStyle(fontSize: 14, color: Colors.white70),
      //     textAlign: TextAlign.end,
      //   ),
      //   SizedBox(width: 15),
      //   Icon(Icons.euro_symbol, color: Colors.orange),
      //   Text(_cost.toStringAsFixed(1),
      //       style: TextStyle(fontSize: 18, color: Colors.white)),
      //   Text(
      //     ' ILS/kW',
      //     style: TextStyle(fontSize: 14, color: Colors.white70),
      //     textAlign: TextAlign.end,
      //   ),
      // ]),
      //),
      body: Container(
        color: Theme.of(context).primaryColor,
        child: ListView(
          children: [
            //EvCalcTitle(),
            _buildSeparator(),
            SizedBox(height: 5),
            MyEditBox.fromDbl(
                title: 'Расход [W/km]',
                value: _consumptionWKm,
                onChange: _getConsumption),
            SizedBox(height: 5),
            MyEditBox.fromDbl(
                title: 'Время зарядки [min]',
                value: _chargeTime,
                onChange: _getChargeTime),
            SizedBox(height: 5),
            _buildSeparator(),

            //MyTextBox.fromDbl(title: 'Заряд [kW]', value: _consumptionKW),
            //MyTextBox.fromDbl(
            //    title: 'Стоимость [ILS]', value: _consumptionNis, digits: 2),
            MyTextBox.fromInt(title: 'Километраж [km]', value: _mileage),
            //MyTextBox('Остаток Пути [km]', _remainDist.toStringAsFixed(1)),
            //MyTextBox('Время зарядки', '${DateFormat.Hm().format(dt)}'),
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
      setState(() {
        // var evStp = value as EvSetupData;
        // if (null != evStp) {
        //   _batteryFullPow = evStp.batteryFullPower;
        //   _chargerAc = evStp.chargerAc;
        //   _chargerDc = evStp.chargerDc;
        //   _cost = evStp.electricityCost;
        //   _extraPay = evStp.extraPay;
        //   _acPhases = evStp.acPhases;
        //   _acVoltage = evStp.acVoltage;
        // }
      });
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
