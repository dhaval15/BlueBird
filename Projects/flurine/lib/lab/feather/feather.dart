import 'package:flutter/material.dart';

abstract class Param extends StatelessWidget{
  final String label;
  final Function(dynamic value) _onChanged;

  Param(this.label,this._onChanged);

  void submitValue(dynamic value){
    _onChanged(value);
  }
}

class TextParam extends Param {
  TextParam(String label, Function(dynamic value) onChanged) : super(label, onChanged);


  @override
  Widget build(BuildContext context) {
    return TextField(
      onChanged: submitValue,
      decoration: InputDecoration(
        labelText:label,
      ),
    );
  }
}

class SceneParam extends Param {
  
  SceneParam(String label, Function(dynamic value) onChanged) : super(label, onChanged);

  @override
  Widget build(BuildContext context) {
    return TextField(
      onChanged: submitValue,
      decoration: InputDecoration(
        labelText:label,
      ),
    );
  }
}