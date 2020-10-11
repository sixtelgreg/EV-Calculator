import 'package:shared_preferences/shared_preferences.dart';

final EvSetup evSetup = EvSetup.instance;

// class EvSetupData {
//   double batteryFullPower = 0.0;
//   int chargerAc = 0;
//   int chargerDc = 0;
//   double electricityCost = 0.0;

//   bool chargerAC = true;
//   double extraPay = 0.0;
//   int acVoltage = 220;
//   int acPhases = 1;
// }

class EvSetup {
  static final EvSetup _instance = EvSetup();
  static EvSetup get instance => _instance;

  double get getBattUsable => (_batteryFullPower -
      _batteryFullPower * 0.05); // 5% of battery is not usable

  double get getAcPower => ((_acVoltage * _acPhases * _chargerAmp) / 1000.0);

  final String _batteryRemainPowerKey = 'BatteryRemainPower';
  double _batteryRemainPower = 20.0;
  double get getBatteryRemainPower => _batteryRemainPower;
  Future<double> setBatteryRemainPower(double val) async {
    final prefs = await SharedPreferences.getInstance();
    _batteryRemainPower = val;
    await prefs.setDouble(_batteryRemainPowerKey, _batteryRemainPower);
    print('saved BatteryRemainPower :$_batteryRemainPower');
    return _batteryRemainPower;
  }

  final String _batteryFullPowerKey = 'BatteryFullPower';
  double _batteryFullPower = 44.5;
  double get getBatteryFullPower => _batteryFullPower;
  Future<double> setBatteryFullPower(double val) async {
    final prefs = await SharedPreferences.getInstance();
    _batteryFullPower = val;
    await prefs.setDouble(_batteryFullPowerKey, _batteryFullPower);
    print('saved BatteryFullPower :$_batteryFullPower');
    return _batteryFullPower;
  }

  final String _chargerAmpKey = 'ChargerAmpKey';
  int _chargerAmp = 16;
  int get getChargerAmp => _chargerAmp;
  Future<int> setChargerAmp(int val) async {
    final prefs = await SharedPreferences.getInstance();
    _chargerAmp = val;
    await prefs.setInt(_chargerAmpKey, _chargerAmp);
    print('saved ChargerAmp :$_chargerAmp');
    return _chargerAmp;
  }

  final String _chargerKWtKey = 'ChargerKWtKey';
  int _chargerKWt = 55;
  int get getChargerKWt => _chargerKWt;
  Future<int> setChargerKWt(int val) async {
    final prefs = await SharedPreferences.getInstance();
    _chargerKWt = val;
    await prefs.setInt(_chargerKWtKey, _chargerKWt);
    print('saved ChargerKWt :$_chargerKWt');
    return _chargerKWt;
  }

  final String _electricityCostKey = 'ElectricityCost';
  double _electricityCost = 0.6;
  double get getElectricityCost => _electricityCost;
  Future<double> setElectricityCost(double val) async {
    final prefs = await SharedPreferences.getInstance();
    _electricityCost = val;
    await prefs.setDouble(_electricityCostKey, _electricityCost);
    print('saved ElectricityCost :$_electricityCost');
    return _electricityCost;
  }

  final String _chargerACKey = 'ChargerAC';
  bool _chargerAC = true;
  bool get getChargerAC => _chargerAC;
  Future<bool> setChargerAC(bool val) async {
    final prefs = await SharedPreferences.getInstance();
    _chargerAC = val;
    await prefs.setBool(_chargerACKey, _chargerAC);
    print('saved ChargerAC :$_chargerAC');
    return _chargerAC;
  }

  final String _extraPayKey = 'ExtraPay';
  double _extraPay = 0.0;
  double get getExtraPay => _extraPay;
  Future<double> setExtraPay(double val) async {
    final prefs = await SharedPreferences.getInstance();
    _extraPay = val;
    await prefs.setDouble(_extraPayKey, _extraPay);
    print('saved ExtraPay :$_extraPay');
    return _extraPay;
  }

  final String _acVoltageKey = 'AcVoltage';
  int _acVoltage = 220;
  int get getAcVoltage => _acVoltage;
  Future<int> setAcVoltage(int val) async {
    final prefs = await SharedPreferences.getInstance();
    _acVoltage = val;
    await prefs.setInt(_acVoltageKey, _acVoltage);
    print('saved AcVoltage :$_acVoltage');
    return _acVoltage;
  }

  final String _acPhasesKey = 'AcPhases';
  int _acPhases = 1;
  int get getAcPhases => _acPhases;
  Future<int> setAcPhases(int val) async {
    final prefs = await SharedPreferences.getInstance();
    _acPhases = val;
    await prefs.setInt(_acPhasesKey, _acPhases);
    print('saved AcPhases :$_acPhases');
    return _acPhases;
  }

  Future<void> read() async {
    final prefs = await SharedPreferences.getInstance();

    _batteryFullPower = prefs.getDouble(_batteryFullPowerKey) ?? 10.0;
    print('read BatteryFullPower: $_batteryFullPower');

    _batteryRemainPower =
        prefs.getDouble(_batteryRemainPowerKey) ?? _batteryFullPower;
    print('read BatteryRemainPower: $_batteryRemainPower');

    _chargerAmp = prefs.getInt(_chargerAmpKey) ?? 10;
    print('read ChargerAmp: $_chargerAmp');

    _chargerKWt = prefs.getInt(_chargerKWtKey) ?? 55;
    print('read ChargerKWt: $_chargerKWt');

    _electricityCost = prefs.getDouble(_electricityCostKey) ?? 1.0;
    print('read ElectricityCost: $_electricityCost');

    _chargerAC = prefs.getBool(_chargerACKey) ?? true;
    print('read ChargerAC: $_chargerAC');

    _extraPay = prefs.getDouble(_extraPayKey) ?? 0.0;
    print('read ExtraPay: $_extraPay');

    _acVoltage = prefs.getInt(_acVoltageKey) ?? 220;
    print('read AcVoltage: $_acVoltage');

    _acPhases = prefs.getInt(_acPhasesKey) ?? 1;
    print('read AcPhases: $_acPhases');
  }
}
