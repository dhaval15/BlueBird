import 'package:flurine/lab/extras/extras.dart';
import 'package:flutter/material.dart' hide Flow;

class Test extends StatefulWidget {
  @override
  _TestState createState() => _TestState();
}

class _TestState extends State<Test> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        padding: EdgeInsets.all(8),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[

          ],
        ),
      ),
    );
  }
}







abstract class SelectData{
  final String label;

  SelectData(this.label);

  Widget toWidget() {

  }
}

class SelectColorData extends SelectData{
  final int defaultColor;
  SelectColorData(String label,this.defaultColor):super(label);
}


class SelectIntData extends SelectData{
  final Trio<int,int,int> range;
  SelectIntData(String label,this.range):super(label);
}

class SelectDoubleData extends SelectData{
  final Trio<double,double,double> range;

  SelectDoubleData(String label,this.range):super(label);
}

class SelectStringData extends SelectData {
  final String defaultString;

  SelectStringData(String label,this.defaultString):super(label);
}