import 'package:flutter/material.dart';
import 'package:flutter_my_clipboard/theme/theme_changer.dart';
import 'package:provider/provider.dart';

class AppMenuItem extends StatelessWidget {
  final VoidCallback? onPressed;
  final IconData icon;
  final Color? color; 
  const AppMenuItem(
      {Key? key, required this.onPressed, required this.icon, this.color})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
   final theme = Provider.of<ThemeChanger>(context);
    return Expanded(
      child: Padding(
        padding: const EdgeInsets.only(left: 2, right: 2, top: 5, bottom: 0),
        child: Container(
            height: 50,
            //width: 60,
            decoration: BoxDecoration(
                borderRadius: const BorderRadius.all(Radius.circular(10.0)),
                shape: BoxShape.rectangle,
                color: color ?? theme.getTheme
                    .secondaryHeaderColor), //Color.fromARGB(255, 240, 232, 232)),
            child: IconButton(
              
              onPressed: onPressed,
              icon: Icon(icon, 
              //color: color ?? Colors.black
              ),
              splashRadius: 30,
            )),
      ),
    );
  }
}
