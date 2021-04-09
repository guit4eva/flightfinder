import 'package:flutter/material.dart';

class CustomElevatedButton extends StatelessWidget {
  @required
  final String label;
  final Function onPressed;
  final Color? bgColor;
  final Color? textColor;

  const CustomElevatedButton({
    Key? key,
    required this.label,
    required this.onPressed,
    this.bgColor,
    this.textColor,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
        onPressed: onPressed as void Function()? ?? () {},
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Text(
            label,
            style: TextStyle(color: textColor),
          ),
        ),
        style: ElevatedButton.styleFrom(primary: bgColor));
  }
}
