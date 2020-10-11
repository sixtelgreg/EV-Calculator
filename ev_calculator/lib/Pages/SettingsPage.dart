import 'dart:math';

import 'package:ev_calculator/EvSetup.dart';
import 'package:ev_calculator/MyEditBox.dart';
import 'package:ev_calculator/MyTextBox.dart';
import 'package:flutter/material.dart';

class SettingsPage extends StatefulWidget {
  SettingsPage({Key key}) : super(key: key);

  //const SettingsPage.editor({@required this.tune});
  //final EvSetupData tune;

  @override
  _SettingsPageState createState() => _SettingsPageState();
}

class _SettingsPageState extends State<SettingsPage> {
  var _batteryFullPow = 10.0; // 44.5
  var _chargerAc = 16; // 32 A
  var _chargerDc = 55; // 75 kW
  var _electricityCost = 1.0; // 0.5
  var _isAcMode = true;
  var _extraPay = 0.0;
  var _acVoltage = 220;
  var _acPhases = 1;

  var _batteryFullPowOrig = 10.0;
  var _chargerAcOrig = 10;
  var _chargerDcOrig = 10;
  var _electricityCostOrig = 1.0;
  var _isAcModeOrig = true;
  var _extraPayOrig = 0.0;
  var _acVoltageOrig = 220;
  var _acPhasesOrig = 1;

  get _setupChanged =>
      _batteryFullPowOrig != _batteryFullPow ||
      _chargerAcOrig != _chargerAc ||
      _chargerDcOrig != _chargerDc ||
      _isAcModeOrig != _isAcMode ||
      _electricityCostOrig != _electricityCost ||
      _extraPayOrig != _extraPay ||
      _acVoltageOrig != _acVoltage ||
      _acPhasesOrig != _acPhases;

  @override
  void initState() {
    super.initState();

    evSetup.read();

    //evSetup.read().then((val) {
    //setState(() {
    _batteryFullPow = _batteryFullPowOrig = evSetup.getBatteryFullPower;
    _chargerAc = _chargerAcOrig = evSetup.getChargerAmp;
    _chargerDc = _chargerDcOrig = evSetup.getChargerKWt;
    _isAcMode = _isAcModeOrig = evSetup.getChargerAC;
    _electricityCost = _electricityCostOrig = evSetup.getElectricityCost;

    _extraPay = _extraPayOrig = evSetup.getExtraPay;
    _acVoltage = _acVoltageOrig = evSetup.getAcVoltage;
    _acPhases = _acPhasesOrig = evSetup.getAcPhases;
    //});
    //});
  }

  @override
  void dispose() {
    super.dispose();
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

  void _getBattery(double val) {
    setState(() {
      _batteryFullPow = val;
    });
  }

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

  void _getCost(double val) {
    setState(() {
      _electricityCost = val;
    });
  }

  void _getExtraPay(double val) {
    setState(() {
      _extraPay = val;
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
    if (_batteryFullPow != _batteryFullPowOrig) {
      evSetup.setBatteryFullPower(_batteryFullPow).then((v) {
        setState(() {
          //_batteryFullPow = v;
        });
      });
    }

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

    if (_electricityCost != _electricityCostOrig) {
      evSetup.setElectricityCost(_electricityCost).then((v) {
        setState(() {
          //_electricityCost = v;
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

    if (_extraPay != _extraPayOrig) {
      evSetup.setExtraPay(_extraPay).then((v) {
        setState(() {
          //_extraPay = v;
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
        title: Center(child: const Text('Settings')),
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
                      Text(_isAcMode ? 'Charger AC' : 'Charger DC',
                          style:
                              TextStyle(fontSize: 22, color: Colors.white70)),
                      SizedBox(width: 50),
                      Icon(_isAcMode ? Icons.power : Icons.ev_station,
                          color:
                              _isAcMode ? Colors.redAccent : Colors.greenAccent,
                          size: 45),
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
              MyTextBox.fromDbl(
                  title: (_isAcMode ? 'AC' : 'DC') + ' Power [kW]',
                  value: _isAcMode
                      ? ((_acPhases * _acVoltage * _chargerAc) / 1000.0)
                      : _chargerDc * 1.0),
              _buildSeparator(),
              SizedBox(height: 5),
              MyEditBox.fromDbl(
                  title: 'Car Battery [KW]',
                  value: _batteryFullPow,
                  onChange: _getBattery),
              SizedBox(height: 5),
              _buildSeparator(),
              SizedBox(height: 5),
              MyEditBox.fromInt(
                  title: 'AC Charger [A]',
                  value: _chargerAc,
                  onChange: _getChargerAC),
              SizedBox(height: 5),
              MyEditBox.fromInt(
                  title: 'DC Charger [kW]',
                  value: _chargerDc,
                  onChange: _getChargerDC),
              SizedBox(height: 5),
              _buildSeparator(),
              SizedBox(height: 5),
              MyEditBox.fromDbl(
                  title: 'Cost 1kW [ILS]',
                  value: _electricityCost,
                  onChange: _getCost),
              SizedBox(height: 5),
              MyEditBox.fromDbl(
                  title: 'Extra Pay [ILS]',
                  value: _extraPayOrig,
                  onChange: _getExtraPay),
              SizedBox(height: 5),
              _buildSeparator(),
              SizedBox(height: 5),
              MyEditBox.fromInt(
                  title: 'AC Voltage 1 Phase',
                  value: _acVoltage,
                  onChange: _getAcVoltage),
              SizedBox(height: 5),
              MyEditBox.fromInt(
                  title: 'Using Phases',
                  value: _acPhases,
                  onChange: _getAcPases),
              SizedBox(height: 5),
              _buildSeparator(),
              //MyTextBox.fromDbl(
              //    title: 'AC Calculated Power [kW]',
              //    value: (_acPhases * _acVoltage * _chargerAc) / 1000.0),
              // IconButton(
              //     icon: Icon(Icons.save,
              //         color: _setupChanged ? Colors.cyan : Colors.white70,
              //         size: 50),
              //     onPressed: _setupChanged ? _saveSetup : null)
            ],
          ),
        ),
      ),
    );
  }
}
