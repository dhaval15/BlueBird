import 'dart:collection';
import 'dart:ui';

import 'package:flurine_lambda/flurine_lambda.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../lambda_utils.dart';

abstract class Scene {
  final List initialData;
  final String type;

  Scene(this.type, {this.initialData});

  Widget build(List params);
}

class SceneRenderer {
  static Map<String, Scene> _scenes = HashMap();

  static void register(Scene scene) => _scenes[scene.type] = scene;

  static void registerMany(Map<String, Scene> map) {
    _scenes.addAll(map);
  }

  final List<Lambda> lambdas;
  final Scene scene;

  SceneRenderer._({this.lambdas, this.scene});

  factory SceneRenderer.of(String type, List<Lambda> lambdas) =>
      SceneRenderer._(
        lambdas: lambdas,
        scene: _scenes[type],
      );

  Future<Widget> render() async {
    await lambdas.execute();
    return FlowBuilder(
      flow: CombinerFlow(lambdas.map((l) => l.vein).toList()),
      builder: (context, data) => scene.build(data),
      initialData: scene.initialData,
    );
  }
}

class TextScene extends Scene {
  TextScene() : super('text');

  @override
  Widget build(List params) {
    return Text(
      '${params[0]}',
      style: TextStyle(
        fontSize: 15.0+params[1]*5,
      ),
    );
  }
}

class TestScene extends StatefulWidget {
  @override
  _TestSceneState createState() => _TestSceneState();
}

class _TestSceneState extends State<TestScene> {
  Widget child;

  @override
  void initState() {
    super.initState();
    _load();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        child: Center(
          child: child,
        ),
      ),
    );
  }

  _load() async {
    await Vein.init();
    SceneRenderer.register(TextScene());
    child = await SceneRenderer.of('text', [Lambda.parse('\$tm(1)\$'),Lambda.parse('\$tm(1)\$')]).render();
    setState(() {});
  }
}
