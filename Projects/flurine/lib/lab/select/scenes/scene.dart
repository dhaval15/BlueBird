
import 'package:flurine/lab/canvas/scene.dart';
import 'package:flurine/lab/canvas/scenes/align.dart';
import 'package:flurine/lab/canvas/scenes/container.dart';
import 'package:flurine/lab/canvas/scenes/text.dart';
import 'package:flurine/main.dart';
import 'package:flutter/material.dart';

class SelectScene extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Dialog(
      child: Container(
        child: ListView(
          children: <Widget>[
            SceneTile(ContainerScene.withValues()),
            SceneTile(TextScene.withValues()),
            SceneTile(AlignScene.withValues()),
          ],
        ),
      ),
    );
  }
}

class SceneTile extends StatelessWidget {
  IconData get icon => null;
  final Scene scene;
  String get subtitle => '';
  String get title => scene.title;

  const SceneTile(this.scene);

  @override
  Widget build(BuildContext context) {
    return ListTile(
      title: Text(title),
      subtitle: Text(subtitle),
      leading: CircleAvatar(
        child: icon != null ? Icon(icon) : Text(title[0]),
      ),
      onTap: () {
        GlobalNavigator.of(context).onPop(scene);
      },
    );
  }
}
