

import 'package:flurine/lab/canvas/utils.dart';
import 'package:flurine/lab/select/scenes/container.dart';
import 'package:flurine_lambda/flurine_lambda.dart';
import 'package:flutter/material.dart';
import '../utils.dart';
import '../scene.dart';

class ContainerScene extends Scene with SingleChildScene{
  ContainerScene(List<Lambda> lambdas, {List initialProps, String key})
      : super('text', lambdas, key: key, initialProps: initialProps){
    init();
  }

  factory ContainerScene.withValues({
    Scene child,
    int color = 0xFFFFFFFF,
    double height,
    double width,
    EdgeInsets padding,
    EdgeInsets margin,
  }) {
    final p = padding ?? EdgeInsets.all(0);
    final m = margin ?? EdgeInsets.all(0);
    final props = [
      child,
      color,
      height,
      width,
      ... convertInsetsToList(p),
      ... convertInsetsToList(m),
    ];
    return ContainerScene(
      convertToLambdas(props),
      initialProps: props,
    );
  }

  Lambda get child => lambdas[0];

  Lambda get color => lambdas[1];

  Lambda get height => lambdas[2];

  Lambda get width => lambdas[3];

  List<Lambda> get padding => lambdas.sublist(4, 7);

  List<Lambda> get margin => lambdas.sublist(8, 11);

  set color(dynamic formula) {
    updateValue(1, formula);
  }

  set height(dynamic formula) {
    updateValue(2, formula);
  }

  set width(dynamic formula) {
    updateValue(3, formula);
  }

  void setPadding({Lambda left, Lambda top, Lambda right, Lambda bottom}) {
    if (left != null) updateValue(4, left);
    if (top != null) updateValue(5, top);
    if (right != null) updateValue(6, right);
    if (bottom != null) updateValue(7, bottom);
  }

  void setMargin({Lambda left, Lambda top, Lambda right, Lambda bottom}) {
    if (left != null) updateValue(8, left);
    if (top != null) updateValue(9, top);
    if (right != null) updateValue(10, right);
    if (bottom != null) updateValue(11, bottom);
  }

  @override
  Widget build(List values) {
    return Container(
      child: values[0],
      color: Color(values[1]),
      height: values[2],
      width: values[3],
      padding: EdgeInsets.fromLTRB(values[4], values[5],
          values[6], values[7]),
      margin: EdgeInsets.fromLTRB(values[8], values[9],
          values[10], values[11]),
    );
  }

  @override
  Widget get builder => SelectContainer(child.params[0]);

  @override
  String get title => 'Container';

  @override
  Widget get selector => SelectContainer(this);
}
