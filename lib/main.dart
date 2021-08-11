import 'dart:async';
import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'dart:math';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Oblique Strategies',
      theme: ThemeData(fontFamily: 'SanFrancisco'),
      home: MyAppScreen(),
    );
  }
}

class MyAppScreen extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return MyAppScreenState();
  }
}

class MyAppScreenState extends State<MyAppScreen> {
  List<String> _strategies = [];
  final _random = new Random();
  var strategy;

  Future<List<String>> _loadStrategies() async {
    List<String> strategies = [];
    await rootBundle.loadString('assets/os.txt').then((q) {
      for (String i in LineSplitter().convert(q)) {
        strategies.add(i);
      }
    });
    return strategies;
  }

  @override
  void initState() {
    _setup();
    super.initState();
  }

  _setup() async {
    // Retrieve the strategies (Processed in the background)
    List<String> strategies = await _loadStrategies();

    // Notify the UI and display the questions
    setState(() {
      _strategies = strategies;
    });
  }

  randomListItem(List lst) => lst[_random.nextInt(lst.length)];

  String generateRandomStrategy() {
    return randomListItem(_strategies);
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        home: Scaffold(
            body: GestureDetector(
                behavior: HitTestBehavior.opaque,
                onTap: () {
                  setState(() {
                    generateRandomStrategy();
                  });
                },
                child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: <Widget>[
                      Center(
                          child: Padding(
                              padding: EdgeInsets.fromLTRB(10, 0, 10, 0),
                              child: Text(generateRandomStrategy(),
                                  textAlign: TextAlign.center,
                                  style: TextStyle(
                                    color: Colors.black,
                                    fontSize: 18.0,
                                  )))),
                    ]))));
  }
}
