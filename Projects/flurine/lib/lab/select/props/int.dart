import '../../lambda_utils.dart';
import 'select.dart';
import 'package:flutter/material.dart' hide Flow;

class SelectInt extends StatefulWidget {
  final String label;
  final int defaultValue;
  final int begin;
  final int end;
  final int step;
  final String tip;
  final Function(int) onValueChanged;

  const SelectInt({
    this.tip,
    @required this.label,
    @required this.onValueChanged,
    this.defaultValue = 0,
    this.begin = 0,
    this.step = 1,
    this.end = 100,
  }) : assert(defaultValue >= begin && defaultValue <= end);

  @override
  _SelectIntState createState() => _SelectIntState();
}

class _SelectIntState extends State<SelectInt> with FlowMixin<SelectInt> {
  int _value;

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