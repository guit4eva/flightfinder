import 'package:flutter/material.dart';

class CustomDialog {
  final String title;
  final Widget? content;
  final String? leftBtnLabel;
  final Function? leftBtnFunction;
  final String? rightBtnLabel;
  final Function? rightBtnFunction;

  CustomDialog({
    required this.title,
    this.content,
    this.leftBtnLabel,
    this.leftBtnFunction,
    this.rightBtnLabel,
    this.rightBtnFunction,
  });

  showAlertDialog(BuildContext context) {
    AlertDialog alert = AlertDialog(
      title: Text(
        title,
        textAlign: TextAlign.center,
      ),
      content: content,
      actions: [
        if (leftBtnLabel != null)
          CustomDialogButton(label: leftBtnLabel!, function: leftBtnFunction!),
        rightBtnLabel != null
            ? CustomDialogButton(
                label: rightBtnLabel!, function: rightBtnFunction!)
            : CustomDialogButton(
                label: 'Close',
                function: () => Navigator.of(context).pop(),
              ),
      ],
    );

    // show the dialog
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return Column(
          // Fit to content and center
          mainAxisSize: MainAxisSize.min,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            alert,
          ],
        );
      },
    );
  }
}

class CustomDialogButton extends StatelessWidget {
  final String label;
  final Function function;

  const CustomDialogButton({
    Key? key,
    required this.label,
    required this.function,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return TextButton(
      child: Text(label),
      onPressed: function as void Function()?,
    );
  }
}
