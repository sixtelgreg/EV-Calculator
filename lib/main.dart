//import 'package:ev_calculator/Tabs/DistanceTab.dart';
//import 'package:ev_calculator/Tabs/EvCalculatorTab.dart';
//import 'package:ev_calculator/Tabs/PowerTab.dart';
//import 'package:ev_calculator/Tabs/SummaryTab.dart';
import 'package:ev_calculator/Tabs/TimeTab.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

// class Choice {
//   const Choice({this.title});
//   final String title;
// }

const List<String> choices = const <String>[
  'Trip Calculator',
  //'Calculator',

  //'Time  ->  Distance',
  //'Power F(distance, time)',
  //'EV Summary',
];

void main() {
  runApp(MyApp());
}

class MyApp extends StatefulWidget {
  // This widget is the root of your application.
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> with WidgetsBindingObserver, SingleTickerProviderStateMixin {
  late TabController _tabController;

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance?.addObserver(this);
    _tabController = TabController(vsync: this, length: choices.length);

    _tabController.addListener(() {
      setState(() {});
    });
  }

  @override
  void dispose() {
    _tabController.dispose();
    WidgetsBinding.instance?.removeObserver(this);
    super.dispose();
  }

  void _nextPage(int delta) {
    final int newIndex = _tabController.index + delta;
    if (newIndex < 0 || newIndex >= _tabController.length) return;
    _tabController.animateTo(newIndex);
  }

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) async {
    setState(() {
      //_lastLifecycleState = state;
      switch (state) {
        case AppLifecycleState.inactive:
          //mqtt.disconnect();
          break;
        case AppLifecycleState.paused:
          //mqtt.disconnect();
          break;
        case AppLifecycleState.detached:
          //await suspendingCallBack();
          //mqtt.disconnect();
          break;
        case AppLifecycleState.resumed:
          //await resumeCallBack();
          break;
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.portraitUp,
      DeviceOrientation.portraitDown,
    ]);
    return MaterialApp(
      //title: 'EV Calculator',
      theme: ThemeData(
        primaryColor: Color.fromRGBO(50, 65, 85, 1),
        textTheme: TextTheme(headline1: TextStyle(color: Colors.white)),
        // This is the theme of your application.
        //
        // Try running your application with "flutter run". You'll see the
        // application has a blue toolbar. Then, without quitting the app, try
        // changing the primarySwatch below to Colors.green and then invoke
        // "hot reload" (press "r" in the console where you ran "flutter run",
        // or simply save your changes to "hot reload" in a Flutter IDE).
        // Notice that the counter didn't reset back to zero; the application
        // is not restarted.
        //primarySwatch: Colors.blue,
        // This makes the visual density adapt to the platform that you run
        // the app on. For desktop platforms, the controls will be smaller and
        // closer together (more dense) than on mobile platforms.
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      home: Scaffold(
        backgroundColor: Theme.of(context).primaryColor,
        appBar: PreferredSize(
          preferredSize: const Size.fromHeight(80.0),
          child: AppBar(
            title: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  'EV Calculator',
                  style: TextStyle(color: Colors.orangeAccent, fontWeight: FontWeight.bold, fontSize: 18),
                ),
                SizedBox(width: 110),
                TabPageSelector(
                  controller: _tabController,
                  indicatorSize: 12,
                  selectedColor: Colors.cyanAccent,
                ),
              ],
            ),
            // leading: IconButton(
            //   //tooltip: 'Previous choice',
            //   icon: const Icon(Icons.arrow_back_ios),
            //   onPressed: () {
            //     _nextPage(-1);
            //   },
            // ),
            // actions: [
            //   IconButton(
            //     icon: const Icon(Icons.arrow_forward_ios),
            //     //tooltip: 'Next choice',
            //     onPressed: () {
            //       _nextPage(1);
            //     },
            //   ),
            // ],
            bottom: PreferredSize(
              preferredSize: const Size.fromHeight(60.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  IconButton(
                    padding: EdgeInsets.only(left: 10),
                    icon: const Icon(
                      Icons.arrow_back_ios,
                      color: Colors.cyanAccent,
                    ),
                    onPressed: () => _nextPage(-1),
                  ),
                  Text(
                    '${choices[_tabController.index]}',
                    style: TextStyle(color: Colors.white70, fontWeight: FontWeight.bold, fontSize: 18),
                  ),
                  IconButton(
                    padding: EdgeInsets.only(right: 10),
                    icon: const Icon(
                      Icons.arrow_forward_ios,
                      color: Colors.cyanAccent,
                    ),
                    onPressed: () => _nextPage(1),
                  ),
                ],
              ),
            ),
          ),
        ),
        body: TabBarView(controller: _tabController, children: [
          TimeTab(),
          //EvCalculatorTab(),
          //DistanceTab(),
          //PowerTab(),
          //SummaryTab(),
        ]),
        // bottomNavigationBar: BottomNavigationBar(
        //   currentIndex: 0,
        //   //type: BottomNavigationBarType.fixed,
        //   backgroundColor: Color.fromRGBO(50, 65, 85, 0.7),
        //   fixedColor: Colors.white,
        //   items: [
        //     // BottomNavigationBarItem(
        //     //   title: Text(
        //     //     "BT",
        //     //     style: TextStyle(color: Colors.white70),
        //     //   ),
        //     //   icon: Icon(Icons.bluetooth, color: Colors.white70),
        //     // ),
        //     BottomNavigationBarItem(
        //       title: Text(
        //         "Tune",
        //         style: TextStyle(color: Colors.white70),
        //       ),
        //       icon: Icon(Icons.tune, color: Colors.white70),
        //     ),
        //     BottomNavigationBarItem(
        //       title: Text(
        //         "Settings",
        //         style: TextStyle(color: Colors.white70),
        //       ),
        //       icon: Icon(Icons.settings, color: Colors.white70),
        //     ),
        //   ],
        //   onTap: (int index) {
        //     setState(() {
        //       //_bottomPressedBttIndex = index;
        //       if (0 == index) {
        //         // Tune
        //         //_startBluetoothPage(context);
        //       } else if (1 == index) {
        //         // Settings
        //         //_startSetupPage(context);
        //       }
        //       // else if (2 == index) {
        //       //   // Settings
        //       //   //_startSettingsPage(context);
        //       // }
        //     });
        //   },
        // ),
      ),

      //CalculatorPage(title: 'EV Calculator'),
    );
  }
}
