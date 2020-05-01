import 'package:flurine/lab/canvas/scenes/container.dart';
import 'package:flurine/lab/editor/test.dart';
import 'package:flurine/lab/select/scenes/container.dart';
import 'package:flutter/material.dart';

class Editor extends StatefulWidget {
  @override
  _EditorState createState() => _EditorState();
}

class _EditorState extends State<Editor> {
  ContainerScene masterScene;

  @override
  void initState() {
    super.initState();
    masterScene = ContainerScene.withValues();
    _load();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        color: Colors.green,
        child: Column(
          children: <Widget>[
            Expanded(
                child: masterScene.isRunning
                    ? masterScene.toWidget()
                    : Container()),
            Expanded(
              child: SelectContainer(masterScene)
            ),
          ],
        ),
      ),
    );
  }

  void _load() async {
    await Future.delayed(Duration(seconds: 1));
    await masterScene.start();
    setState(() {

    });
  }
}

class PropsEditor extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      child: GestureDetector(
        onTap: () {
          Navigator.of(context)
              .push(MaterialPageRoute(builder: (context) => Test()));
        },
      ),
    );
  }
}

class PropsNavigator extends StatelessWidget {
  final Widget home;

  PropsNavigator({Key key, this.home}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Navigator(
      initialRoute: '/',
      onGenerateRoute: (settings) {
        if (settings.name == '/')
          return MaterialPageRoute(builder: (context) => home);
        else
          return null;
      },
    );
  }
}
