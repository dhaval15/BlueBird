
import 'package:flurine/lab/canvas/scene.dart';
import 'package:flurine/lab/select/props/select.dart';
import 'package:flurine/lab/select/scenes/scene.dart';
import 'package:flutter/material.dart' hide Flow;

import '../../lambda_utils.dart';

class SelectChild extends StatefulWidget {
  final Function(Widget) onChildChanged;
  final Scene defaultScene;

  const SelectChild({@required this.onChildChanged, this.defaultScene});

  @override
  _SelectChildState createState() => _SelectChildState();
}

class _SelectChildState extends State<SelectChild> with FlowMixin<SelectChild> {
  Scene _scene;

  @override
  void initState() {
    super.initState();
    _scene = widget.defaultScene;
  }

  @override
  Widget build(BuildContext context) {
    return SelectProp(
      label: 'Child',
      tip: 'Select a widget as child',
      trailing: IconButton(icon: Icon(Icons.add), onPressed: () {}),
      child: FlowBuilder(
        flow: flow,
        initialData: widget.defaultScene,
        builder: (context, data) => GestureDetector(
          onTap: () async {
            if (widget.defaultScene != null) {
              Navigator.of(context).push(MaterialPageRoute(
                  builder: (context) => data.builder));
            } else {
              Scene scene = await showDialog(context: context,child: SelectScene());
              flow.add(scene);
            }
          },
          child: Text(data != null ? data.title : 'Select a new one'),
        ),
      ),
    );
  }
}
