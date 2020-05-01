import 'dart:async';

import 'package:flurine_lambda/flurine_lambda.dart';
import 'package:flutter/material.dart' hide Flow;

import 'lab/lambda_utils.dart';

class FlowExample extends StatefulWidget {
  @override
  _FlowExampleState createState() => _FlowExampleState();
}

class _FlowExampleState extends State<FlowExample> {
  Flow flow;
  Flow flow1 = Flow(), flow2 = Flow(), flow3 = Flow();

  @override
  void initState() {
    super.initState();
    load();
  }

  void load() async {
    Timer.periodic(Duration(seconds: 1), (timer) {
      flow1.add(timer.tick);
    });
    await Future.delayed(Duration(seconds: 2));
    flow2.add('Hello');
    await Future.delayed(Duration(seconds: 2));
    flow3.add('Dhaval');
    await Future.delayed(Duration(seconds: 2));
    flow2.add('Dhaval');
    await Future.delayed(Duration(seconds: 2));
    flow3.add('Patel');
    await Future.delayed(Duration(seconds: 2));
    setState(() {
      flow = Flow.combine([flow1, flow2, flow3]);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        child: flow != null
            ? FlowBuilder(
                flow: flow,
                initialData: [1, 'Hello', 'World'],
                builder: (context, data) => Row(
                  children: <Widget>[
                    Text('${data[0]}'),
                    SizedBox(width: 12),
                    Text(data[1]),
                    SizedBox(width: 12),
                    Text(data[2]),
                    SizedBox(width: 12),
                  ],
                ),
              )
            : null,
      ),
    );
  }
}

class Temp4 extends StatefulWidget {
  @override
  _Temp4State createState() => _Temp4State();
}

class _Temp4State extends State<Temp4> {
  Lambda lambda;

  @override
  void initState() {
    super.initState();
    _load();
  }

  void _load() async {
    await Vein.init();
    lambda = Lambda.parse('\$cc(tm("m",1)," : ",tm(1))\$');
    await lambda.execute();
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        child: Center(
          child: FlowBuilder(
            initialData: 'Hello',
            builder: (context, data) => Text(
              '$data',
              style: TextStyle(
                fontSize: 128,
                fontWeight:FontWeight.w100,
              ),
            ),
            flow: lambda.vein,
          ),
        ),
      ),
    );
  }
}

class TimeHandler extends Handler {
  @override
  Future compute() async {
    if(params[0] == 'm')
      return DateTime.now().minute;
    return DateTime.now().second;
  }

  @override
  Duration get repeatingDuration => Duration(seconds: params.last);
}

class ConcatHandler extends Handler{

  @override
  Duration get repeatingDuration => null;

  @override
  Future compute() async{
    return params.join();
  }

}



