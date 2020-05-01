import 'package:flurine/lab/canvas/utils.dart';
import 'package:flurine_lambda/flurine_lambda.dart';
import 'package:flutter/material.dart';

import '../scene.dart';

class TextScene extends Scene {
  TextScene(List<Lambda> lambdas, {List initialProps, String key})
      : super('text', lambdas, key: key, initialProps: initialProps);

  factory TextScene.withValues({
    String text = 'Hello World',
    int color = 0xFF0000000,
    double fontSize = 32,
    int fontWeight = 3,
    int letterSpacing = 0,
    int wordSpacing = 0,
  }) {
    final props = [
      text,
      color,
      fontSize,
      fontWeight,
      letterSpacing,
      wordSpacing
    ];
    return TextScene(
      convertToLambdas(props),
      initialProps: props,
    );
  }

  Lambda get text => lambdas[0];

  Lambda get color => lambdas[1];

  Lambda get fontSize => lambdas[2];

  Lambda get fontWeight => lambdas[3];

  Lambda get letterSpacing => lambdas[4];

  Lambda get wordSpacing => lambdas[5];

  set text(dynamic lambda) {
    updateValue(0,lambda);
  }

  set color(dynamic lambda) {
    updateValue(1,lambda);
  }

  set fontSize(dynamic lambda) {
    updateValue(2,lambda);
  }

  set fontWeight(dynamic lambda) {
    updateValue(3,lambda);
  }

  set letterSpacing(dynamic lambda) {
    updateValue(4,lambda);
  }

  set wordSpacing(dynamic lambda) {
    updateValue(5,lambda);
  }

  @override
  Widget build(List values) {
    return Text(
      values[0],
      style: TextStyle(
        color: Color(values[1]),
        fontSize: values[2],
        fontWeight: FontWeight.values[values[3]],
        letterSpacing: values[4],
        wordSpacing: values[5],
      ),
    );
  }

  @override
  Widget get builder => throw UnimplementedError();

  @override
  String get title => 'Text';

  @override
  // TODO: implement selector
  Widget get selector => null;
}
