import 'package:flutter/material.dart' hide Flow;

class SelectProp extends StatelessWidget {
  final Widget child, leading, trailing;
  final String label;
  final String tip;

  const SelectProp({
    this.tip = '',
    this.label,
    this.child,
    this.leading,
    this.trailing,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      children: <Widget>[
        Flexible(
            flex: 1,
            fit: FlexFit.tight,
            child: Text(
              label,
              style: TextStyle(fontSize: 14),
            )),
        Flexible(
          fit: FlexFit.tight,
          flex: 4,
          child: Row(
            children: <Widget>[
              leading ?? SizedBox(width: 16),
              Expanded(
                child: Container(
                  decoration: BoxDecoration(
                    color: Colors.black.withAlpha(32),
                    borderRadius: BorderRadius.all(Radius.circular(2)),
                  ),
                  child: child,
                ),
              ),
              trailing ?? SizedBox(width: 16),
            ],
          ),
        )
      ],
    );
  }
}