import 'package:ev_calculator/EvSetup.dart';
import 'package:ev_calculator/MyEditBox.dart';
import 'package:flutter/material.dart';

class EditCostPage extends StatefulWidget {
  EditCostPage({Key? key}) : super(key: key);

  @override
  _EditCostPageState createState() => _EditCostPageState();
}

class _EditCostPageState extends State<EditCostPage> {
  var _electricityCost = 1.0; // 0.5
  var _extraPayOrig = 0.0;
  var _electricityCostOrig = 1.0;
  var _extraPay = 0.0;

  get _setupChanged => _electricityCostOrig != _electricityCost || _extraPayOrig != _extraPay;

  @override
  void initState() {
    super.initState();

    evSetup.read();

    //evSetup.read().then((val) {
    //setState(() {
    _electricityCost = _electricityCostOrig = evSetup.getElectricityCost;
    _extraPay = _extraPayOrig = evSetup.getExtraPay;
    //});
    //});
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

  void _saveSetup() {
    if (_electricityCost != _electricityCostOrig) {
      evSetup.setElectricityCost(_electricityCost).then((v) {
        setState(() {
          //_electricityCost = v;
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
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Center(child: const Text('Edit Cost')),
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
              SizedBox(height: 50),

              //_buildSeparator(),
              //SizedBox(height: 5),
              MyEditBox.fromDbl(title: 'Cost 1kW [ILS]', value: _electricityCost, onChange: _getCost),
              SizedBox(height: 30),
              MyEditBox.fromDbl(title: 'Extra Pay [ILS]', value: _extraPayOrig, onChange: _getExtraPay),
              SizedBox(height: 5),
              //_buildSeparator(),
              // SizedBox(height: 5),

              // _buildSeparator(),
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
