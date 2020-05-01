
import 'package:flurine_lambda/flurine_lambda.dart';
import 'package:flutter/material.dart';

List<Lambda> convertToLambdas(List list) => list.map((e) => Lambda.value(e)).toList();

List convertInsetsToList(EdgeInsets insets) => [insets.left,insets.top,insets.right,insets.bottom];

extension UnitExtension on Object{
  int get intValue => this is int
      ? this
      : this is double ? (this as double).toInt() : int.parse(this);

  double get doubleValue => this is double
      ? this
      : this is int ? (this as int).toDouble() : double.parse(this);

  Color get colorValue => Color(intValue);
}