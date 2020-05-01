import 'package:flurine/lab/canvas/utils.dart';
import 'package:flurine_lambda/flurine_lambda.dart';
import 'package:flutter/material.dart';

import '../scene.dart';

class AlignScene extends Scene with SingleChildScene{
  AlignScene(List<Lambda> lambdas, {List initialProps, String key})
      : super('text', lambdas, key: key, initialProps: initialProps){
    init();
  }

  factory AlignScene.withValues({
    Scene child,
    double alignmentX = 0,
    double alignmentY = 0,
  }) {
    final props = [
      child,
      alignmentX,
      alignmentY,
    ];
    return AlignScene(
      convertToLambdas(props),
      initialProps: props,
    );
  }

  Lambda get alignmentX => lambdas[1];

  Lambda get alignmentY => lambdas[2];

  set alignmentX(dynamic formula) {
    updateValue(1, formula);
  }

  set alignmentY(dynamic formula){
    updateValue(2,formula);
  }



  @override
  Widget build(List values) {
    return Align(
      child: values[0],
      alignment: Alignment(values[1].doubleValue,values[2].doubleValue),
    );
  }

  @override
  Widget get builder => Container();

  @override
  String get title => 'Align';

  @override
  Widget get selector => null;
}
