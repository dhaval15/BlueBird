import 'package:flurine/lab/scene/scene.dart';
import 'package:flurine/temp.dart';
import 'package:flurine_lambda/flurine_lambda.dart';
import 'package:flutter/material.dart';
import 'package:flutter/foundation.dart'
    show debugDefaultTargetPlatformOverride;

const TIME = 'tm';
const CONCAT = 'cc';

void main() {
  debugDefaultTargetPlatformOverride = TargetPlatform.fuchsia;
  Handler.registerMany({
    CONST: () => ConstHandler(),
    TIME: () => TimeHandler(),
    CONCAT: () => ConcatHandler(),
  });
  runApp(MyApp());
}

class GlobalNavigator extends StatelessWidget {
  final Widget child;
  final Future Function(Route) onPush;
  final Function([dynamic result]) onPop;

  const GlobalNavigator({this.child, this.onPush, this.onPop});

  factory GlobalNavigator.of(BuildContext context) => context.findAncestorWidgetOfExactType<GlobalNavigator>();

  @override
  Widget build(BuildContext context) {
    return child;
  }
}

class MyApp extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flurine Launcher',
      theme: ThemeData(
        primarySwatch: Colors.green,
        //brightness: Brightness.dark,
      ),
      debugShowCheckedModeBanner: false,
      home: Global(),
      //home: FlowExample(),
    );
  }
}

class Global extends StatefulWidget {
  @override
  _GlobalState createState() => _GlobalState();
}

class _GlobalState extends State<Global> {

  Future _onPush(Route route) => Navigator.of(context).push(route);

  void _onPop([dynamic result]) => Navigator.of(context).pop(result);

  @override
  Widget build(BuildContext context) {
    return GlobalNavigator(
      onPush: _onPush,
      onPop: _onPop,
      child: TestScene(),
    );
  }
}



