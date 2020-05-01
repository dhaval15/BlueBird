import 'dart:async';
import 'dart:core';

import 'package:flurine/lab/database/database.dart';
import 'package:flurine_lambda/flurine_lambda.dart';
import 'package:flutter/material.dart' hide Flow;

import '../lambda_utils.dart';


extension SceneExtension on Scene {
  void updateValue(int index, dynamic value) {
    final f = lambdas[index];
    f.update(value);
  }
}

abstract class Scene with Flux {
  bool isRunning = false;
  final String _type;
  List<Lambda> lambdas;
  final List initialProps;

  Widget get builder;
  String get title;

  Widget get selector;

  Scene(this._type, this.lambdas, {String key, this.initialProps}) {
    this.key = key;
  }

  factory Scene.fromKey(String key) => Scene.fromJson({});

  Map<String, dynamic> toJson() => {
    'k': key,
    't': _type,
    'f': lambdas,
  };

  Widget build(List data);

  Widget toWidget() {
    return FlowBuilder(
      initialData: initialProps,
      flow: combine(lambdas, initialProps),
      builder: (context, data) {
        return build(data);
      },
    );
  }

  factory Scene.fromJson(Map<String, dynamic> data) {
    /*String type = data['t'];
    String key = data['k'];
    List<Lambda> lambdas = data['f'];
    switch (type) {
      case 'text':
        return FText(lambdas, key: key);
      case 'screen':
        return FText(lambdas, key: key);
      case 'container':
        return FContainer(lambdas, key: key);
      case 'stack':
        return FStack(lambdas, key: key);
      case 'column':
        return FColumn(lambdas, key: key);
      case 'row':
        return FRow(lambdas, key: key);
      case 'tap':
        return FTap(lambdas, key: key);
      case 'image':
        return FText(lambdas, key: key);
      case 'align':
        return FText(lambdas, key: key);
      case 'progress':
        return FProgress(lambdas, key: key);
      case 'html':
        return FHtml(lambdas, key: key);
      case 'streambuilder':
        return FText(lambdas, key: key);
      case 'list':
        return FList(lambdas);
    }*/
    return null;
  }

  Future start() async {
    for (int i = 0; i < lambdas.length; i++) {
      await lambdas[i].execute();
    }
    isRunning = true;
  }

  void stop() {
    for (final lambda in lambdas) {
      //if (lambda is Lambda) lambda.stop();
    }
  }
}

mixin SingleChildScene on Scene{
  Lambda get child => lambdas[0];
  Future setChild(dynamic value) async {
    child.params[0]?.flexineValue?.stop();
    if (value is Scene || value is Lambda)
      child.update(value);
    else
      throw Exception('Parameter passed is niether flexine or formula');
  }

  void init() {
    
  }
}

Flow combine(List<Lambda> lambdas,List initialValues)=> Flow.combine(lambdas.map((e) => e.vein).toList(),initialValues: initialValues);