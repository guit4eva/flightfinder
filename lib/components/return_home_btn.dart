// =============================================================================
// Home Button (AppBar)
// =============================================================================
import 'package:flutter/material.dart';

class HomeBtn extends StatelessWidget {
  const HomeBtn({
    Key key,
    this.confirmHome,
  }) : super(key: key);

  final bool confirmHome;

  @override
  Widget build(BuildContext context) {
    return IconButton(
        icon: Icon(Icons.home),
        onPressed: () =>
            Navigator.pushNamedAndRemoveUntil(context, '/', (_) => false));
  }
}
