import 'package:flutter/material.dart';

class SmallHeader extends StatelessWidget {
  final String text;

  const SmallHeader({
    Key key,
    @required this.text,
  }) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Text(
        text,
        style: TextStyle(fontSize: 22.0),
      ),
    );
  }
}
