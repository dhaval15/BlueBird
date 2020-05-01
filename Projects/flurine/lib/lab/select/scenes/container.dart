
import 'package:flurine/lab/canvas/scenes/container.dart';
import 'package:flurine/lab/select/props/child.dart';
import 'package:flurine/lab/select/props/int.dart';
import 'package:flurine/lab/select/props/string.dart';
import 'package:flutter/material.dart';

class SelectContainer extends StatelessWidget {
  final ContainerScene defaultScene;

  const SelectContainer(this.defaultScene);
  @override
  Widget build(BuildContext context) {
    var color = Color(0xFF000000);
    return Column(
      children: <Widget>[
        SelectChild(
          onChildChanged: (child)async{
            await defaultScene.setChild(child);
          },
          defaultScene: defaultScene.child.params[0],
        ),
        SelectInt(
          defaultValue: 0,
          step: 10,
          begin: 0,
          end: 255,
          label: 'Red',
          onValueChanged: (red){
            color = color.withRed(red);
             defaultScene.color = color.value;
          },
        ),
        SelectInt(
          defaultValue: 0,
          step: 10,
          begin: 0,
          end: 255,
          label: 'Green',
          onValueChanged: (green){
            color = color.withGreen(green);
            defaultScene.color = color.value;
          },
        ),
        SelectInt(
          defaultValue: 0,
          step: 10,
          begin: 0,
          end: 255,
          label: 'Blue',
          onValueChanged: (blue){
            color = color.withBlue(blue);
            defaultScene.color = color.value;
          },
        ),
      ],
    );
  }
}
