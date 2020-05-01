import 'package:flurine/lab/select/props/select.dart';
import 'package:flutter/material.dart';

class SelectString extends StatefulWidget {
  final String label;
  final String defaultValue;
  final String tip;
  final Function(String) onValueChanged;

  const SelectString(
      {this.label, this.defaultValue, this.tip, this.onValueChanged});

  @override
  _SelectStringState createState() => _SelectStringState();
}

class _SelectStringState extends State<SelectString> {
  @override
  Widget build(BuildContext context) {
    return SelectProp(
      tip: widget.tip,
      label: widget.label,
      child: TextField(
        controller: TextEditingController(text: widget.defaultValue),
        onChanged: widget.onValueChanged,
      ),
    );
  }
}
