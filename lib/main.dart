import 'dart:async';
import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Oblique Strategies',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Oblique Strategies")),
      body: Center(
        child: Container(
          child: ListView.builder(
            itemCount: _strategies.length,
            itemBuilder: (context, index) {
              return Text(_strategies[index]);
            },
          ),
        ),
      ),
    );
  }
}
