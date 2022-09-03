import 'package:flutter/material.dart';
import 'package:flutter_my_clipboard/theme/theme_changer.dart';
import 'package:provider/provider.dart';

class AppMenuItem extends StatefulWidget {
  final VoidCallback? onPressed;
  final IconData icon;
  final Color? color;
  final String route;
  const AppMenuItem(
      {Key? key,
      required this.onPressed,
      required this.icon,
      this.color,
      required this.route})
      : super(key: key);

  @override
  State<AppMenuItem> createState() => _AppMenuItemState();
}

class _AppMenuItemState extends State<AppMenuItem> {
  late Color iconColor;
  bool onHover = false;
  @override
  Widget build(BuildContext context) {
    final theme = Provider.of<ThemeChanger>(context);
    iconColor = theme.getTheme.textTheme.bodyText1?.color as Color;
    //navigation = Provider.of<NavigationManager>(context);
    return Expanded(
      child: Padding(
        padding: const EdgeInsets.only(left: 2, right: 2, top: 5, bottom: 0),
        child: MouseRegion(
          onEnter: (hover) {
            setState(() {
              onHover = true;
            });
          },
          onExit: (exit) {
            setState(() {
             onHover = false;
            });
          },
          child: Container(
            decoration: BoxDecoration(
                borderRadius: const BorderRadius.all(Radius.circular(10.0)),
                shape: BoxShape.rectangle,
                color: widget.color ?? theme.getTheme.secondaryHeaderColor),
            child: IconButton(
              onPressed: widget.onPressed,
              icon: Icon(
                color: onHover
                    ? theme.getTheme.cardColor
                    : iconColor,
                widget.icon,
                //color: color ?? Colors.black
              ),
              splashRadius: 20,
            ),
          ),
        ),
      ),
    );
  }
}
