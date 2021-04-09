import 'package:flightfinder/components/custom_dialog.dart';
import 'package:flightfinder/components/menu.dart';
import 'package:flightfinder/components/return_home_btn.dart';
import 'package:flutter/material.dart';

class CustomAppBar extends StatelessWidget implements PreferredSizeWidget {
  const CustomAppBar({
    Key? key,
    this.isHomepage,
  }) : super(key: key);

  final bool? isHomepage;

  @override
  Widget build(BuildContext context) {
    return AppBar(
      automaticallyImplyLeading: false,
      leading: isHomepage == true
          ? null
          : IconButton(
              icon: const Icon(Icons.chevron_left),
              onPressed: () => Navigator.of(context).pop(),
            ),
      actions: [
        Padding(
          padding: const EdgeInsets.only(right: 6.0),
          child: IconButton(
            onPressed: () => CustomDialog(title: 'MENU', content: Menu())
                .showAlertDialog(context),
            icon: Icon(Icons.menu),
          ),
        ),
        if (isHomepage != true) HomeBtn(),
      ],
    );
  }

  @override
  Size get preferredSize => Size.fromHeight(56);
}
