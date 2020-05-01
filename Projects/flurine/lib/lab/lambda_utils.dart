

import 'package:flurine_lambda/flurine_lambda.dart';
import 'package:flutter/material.dart' hide Flow;

typedef FlowBuilderFunc = Widget Function(BuildContext context, dynamic data);

class FlowBuilder extends StatefulWidget {
  final FlowBuilderFunc builder;
  final FlowListener flow;
  final dynamic initialData;

  const FlowBuilder({this.initialData, this.builder, this.flow});

  @override
  _FlowBuilderState createState() => _FlowBuilderState();
}

class _FlowBuilderState extends State<FlowBuilder> {
  dynamic data;

  @override
  void initState() {
    super.initState();
    data = widget.initialData;
    widget.flow?.listen((value) {
      setState(() {
        data = value;
      });
    });
  }

  @override
  void dispose() {
    super.dispose();
    widget.flow?.cancel();
  }

  @override
  Widget build(BuildContext context) {
    return widget.builder(context, data);
  }
}

mixin FlowMixin<T extends StatefulWidget> on State<T>{
  Flow flow;
  @override
  void initState() {
    super.initState();
    flow = Flow();
  }

  @override
  void dispose() {
    super.dispose();
    flow.cancel();
    flow = null;
  }
}

extension LambdaList on List<Lambda>{
  Future execute() async {
    for(final lambda in this){
      await lambda.execute();
    }
  }
}