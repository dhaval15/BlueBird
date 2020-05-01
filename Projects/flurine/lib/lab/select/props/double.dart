

import 'package:flurine/lab/select/props/select.dart';
import 'package:flutter/material.dart' hide Flow;

import '../../lambda_utils.dart';

class SelectDouble extends StatefulWidget {
  final String label;
  final double defaultValue;
  final double begin;
  final double end;
  final double step;
  final String tip;
  final Function(double) onValueChanged;

  const SelectDouble({
    this.tip,
    @required this.label,
    @required this.onValueChanged,
    this.defaultValue = 0,
    this.begin = 0,
    this.step = 0.2,
    this.end = 5,
  }) : assert(defaultValue >= begin && defaultValue <= end);

  @override
  _SelectDoubleState createState() => _SelectDoubleState();
}

class _SelectDoubleState extends State<SelectDouble> with FlowMixin<SelectDouble>{
  double _value;

  @override
  void initState() {
    super.initState();
    _value = widget.defaultValue;
  }

  @override
  Widget build(BuildContext context) {
    return SelectProp(
      label: widget.label,
      leading: IconButton(
          icon: Icon(
            Icons.remove,
            size: 16,
          ),
          onPressed: () {
            _value = _value - widget.step;
            _commitValue();
          }),
      child: Center(
        child: FlowBuilder(
          flow: flow,
          builder: (context, data) => Text(data.toString()),
          initialData: widget.defaultValue,
        ),
      ),
      trailing: IconButton(
          icon: Icon(
            Icons.add,
            size: 16,
          ),
          onPressed: () {
            _value = _value + widget.step;
            _commitValue();
          }),
    );
  }

  void _commitValue() {
    if (_value > widget.end) _value = widget.end;
    if (_value < widget.begin) _value = widget.begin;
    widget.onValueChanged?.call(_value);
    flow.add(_value);
  }
}