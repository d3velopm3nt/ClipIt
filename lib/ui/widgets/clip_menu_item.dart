import 'package:flutter/material.dart';
import 'package:flutter_my_clipboard/theme/theme_changer.dart';
import 'package:provider/provider.dart';

class ClipMenuItem extends StatelessWidget {
  final VoidCallback? onPressed;
  final IconData icon;
  final Color? color;
  const ClipMenuItem(
      {Key? key, required this.onPressed, required this.icon, this.color})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
   final theme = Provider.of<ThemeChanger>(context);
    return Padding(
      padding: const EdgeInsets.only(left: 0, right: 0, top: 5, bottom: 0),
      child: AnimatedContainer(
          height: 50,
          width: 60,
          decoration: BoxDecoration(
              borderRadius: const BorderRadius.all(Radius.circular(10.0)),
              shape: BoxShape.rectangle,
              color: theme.getTheme
                  .secondaryHeaderColor), //Color.fromARGB(255, 240, 232, 232)),
          duration: const Duration(seconds: 2),
          curve: Curves.easeIn,
          child: IconButton(
            onPressed: onPressed,
            icon: Icon(icon, color: color ?? Colors.black),
            splashRadius: 30,
          )),
    );
  }
}
