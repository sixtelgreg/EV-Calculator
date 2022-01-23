import 'dart:math';

import 'package:ev_calculator/EvSetup.dart';
import 'package:ev_calculator/MyEditBox.dart';
import 'package:ev_calculator/MyTextBox.dart';
import 'package:flutter/material.dart';

class EditChargerPage extends StatefulWidget {
  EditChargerPage({Key? key}) : super(key: key);

  //const SettingsPage.editor({@required this.tune});
  //final EvSetupData tune;

  @override
  _EditChargerPageState createState() => _EditChargerPageState();
}

class _EditChargerPageState extends State<EditChargerPage> {
  var _chargerAc = 16; // 32 A
  var _chargerDc = 75; // 75 kW
  var _isAcMode = true;
  var _acVoltage = 220;
  var _acPhases = 1;

  var _chargerAcOrig = 16;
  var _chargerDcOrig = 75;
  var _isAcModeOrig = true;
  var _acVoltageOrig = 220;
  var _acPhasesOrig = 1;

  get _setupChanged =>
      _chargerAcOrig != _chargerAc ||
      _chargerDcOrig != _chargerDc ||
      _isAcModeOrig != _isAcMode ||
      _acVoltageOrig != _acVoltage ||
      _acPhasesOrig != _acPhases;

  @override
  void initState() {
    super.initState();

    evSetup.read();
    _chargerAc = _chargerAcOrig = evSetup.getChargerAmp;
    _chargerDc = _chargerDcOrig = evSetup.getChargerKWt;
    _isAcMode = _isAcModeOrig = evSetup.getChargerAC;
    _acVoltage = _acVoltageOrig = evSetup.getAcVoltage;
    _acPhases = _acPhasesOrig = evSetup.getAcPhases;
  }

  @override
  void dispose() {
    super.dispose();
  }

  // Widget _buildSeparator() {
  //   return Column(children: [
  //     Divider(
  //         height: 4,
  //         thickness: 1,
  //         color: Colors.white24,
  //         indent: 10,
  //         endIndent: 10),
  //     Divider(
  //         height: 4,
  //         thickness: 1,
  //         color: Colors.white24,
  //         indent: 10,
  //         endIndent: 10),
  //   ]);
  // }

  void _getChargerDC(int val) {
    setState(() {
      _chargerDc = val;
    });
  }

  void _getChargerAC(int val) {
    setState(() {
      _chargerAc = val;
    });
  }

  void _getAcVoltage(int val) {
    setState(() {
      _acVoltage = val;
    });
  }

  void _getAcPases(int val) {
    setState(() {
      _acPhases = min(3, max(val, 1));
    });
  }

  void _saveSetup() {
    if (_chargerAc != _chargerAcOrig) {
      evSetup.setChargerAmp(_chargerAc).then((v) {
        setState(() {
          //_chargerAc = v;
        });
      });
    }

    if (_chargerDc != _chargerDcOrig) {
      evSetup.setChargerKWt(_chargerDc).then((v) {
        setState(() {
          //_chargerDc = v;
        });
      });
    }

    if (_isAcMode != _isAcModeOrig) {
      evSetup.setChargerAC(_isAcMode).then((v) {
        setState(() {
          //_isAcMode = v;
        });
      });
    }

    if (_acVoltage != _acVoltageOrig) {
      evSetup.setAcVoltage(_acVoltage).then((v) {
        setState(() {
          //_acVoltage = v;
        });
      });
    }

    if (_acPhases != _acPhasesOrig) {
      evSetup.setAcPhases(_acPhases).then((v) {
        setState(() {
          //_acPhases = v;
        });
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Center(child: const Text('Edit Charger')),
        actions: <Widget>[
          IconButton(
            //color: _changed ? Colors.orange : Colors.white70,
            color: _setupChanged ? Colors.orangeAccent : Colors.white70,
            icon: Icon(Icons.save),
            onPressed: () {
              // var tune = EvSetupData();
              // tune.batteryFullPower = _batteryFullPow;
              // tune.chargerAc = _chargerAc;
              // tune.chargerDc = _chargerDc;
              // tune.electricityCost = _electricityCost;
              // tune.chargerAC = _isAcMode;
              if (_setupChanged) {
                _saveSetup();
              }
              Navigator.of(context).pop();
            },
          ),
        ],
      ),
      body: SizedBox.expand(
        child: Container(
          color: Theme.of(context).primaryColor,
          child: ListView(
            children: [
              SizedBox(height: 30),
              SwitchListTile(
                activeColor: Colors.yellowAccent,
                inactiveThumbColor: Colors.yellowAccent,
                activeTrackColor: Colors.redAccent,
                inactiveTrackColor: Colors.greenAccent,
                title: Padding(
                  padding: EdgeInsets.only(top: 10, left: 10, bottom: 10),
                  child: Row(
                    children: [
                      Text(_isAcMode ? 'Charger AC' : 'Charger DC', style: TextStyle(fontSize: 22, color: Colors.white70)),
                      SizedBox(width: 50),
                      Icon(_isAcMode ? Icons.power : Icons.ev_station, color: _isAcMode ? Colors.redAccent : Colors.greenAccent, size: 45),
                    ],
                  ),
                ),
                value: _isAcMode,
                onChanged: (bool v) {
                  setState(() {
                    _isAcMode = v;
                  });
                },
              ),
              _isAcMode
                  ? Column(children: [
                      SizedBox(height: 10),
                      MyTextBox.fromDbl(title: 'AC Power [kW]', value: (_acPhases * _acVoltage * _chargerAc) / 1000.0),
                      SizedBox(height: 20),
                      MyEditBox.fromInt(title: 'AC Charger [A]', value: _chargerAc, onChange: _getChargerAC),
                      SizedBox(height: 10),
                      MyEditBox.fromInt(title: 'AC Voltage 1 Phase', value: _acVoltage, onChange: _getAcVoltage),
                      SizedBox(height: 10),
                      MyEditBox.fromInt(title: 'Using Phases', value: _acPhases, onChange: _getAcPases),
                      // MyEditBox.fromInt(
                      //title: 'BlaBla', value: 0, onChange: null),
                    ])
                  : Column(children: [
                      SizedBox(height: 30),
                      MyEditBox.fromInt(title: 'DC Charger [kW]', value: _chargerDc, onChange: _getChargerDC),
                      SizedBox(height: 10),
                    ]),
            ],
          ),
        ),
      ),
    );
  }
}
