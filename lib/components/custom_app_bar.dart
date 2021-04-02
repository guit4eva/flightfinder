import 'package:flutter/material.dart';

class CustomAppBar extends StatelessWidget implements PreferredSizeWidget {
  const CustomAppBar({
    Key key,
    this.isHomepage,
  }) : super(key: key);

  final bool isHomepage;

  @override
  Widget build(BuildContext context) {
    return AppBar(
      iconTheme: IconThemeData(color: Colors.black87),
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
            onPressed: () {},
            icon: Icon(
              Icons.menu,
            ),
          ),
        ),
      ],
    );
  }

  @override
  Size get preferredSize => Size.fromHeight(56);
}
