import 'package:flutter/material.dart';
import 'package:flutter_my_clipboard/navigation/clip.navigation.dart';
import 'package:flutter_my_clipboard/theme/theme_changer.dart';
import 'package:provider/provider.dart';

class AppMenuItem extends StatefulWidget {
  final VoidCallback? onPressed;
  final IconData icon;
  final Color? color;
  final String route;
  final String label;
  AppMenuItem({
    Key? key,
    required this.onPressed,
    required this.icon,
    this.color,
    required this.label,
    required this.route,
  }) : super(key: key);

  @override
  State<AppMenuItem> createState() => _AppMenuItemState();
}

class _AppMenuItemState extends State<AppMenuItem> {
  late Color iconColor;
  late Color hoverColor;
  bool onHover = false;
  @override
  Widget build(BuildContext context) {
    final theme = Provider.of<ThemeChanger>(context);
    hoverColor = theme.getTheme.canvasColor;
    var showLabel = widget.label == null ? false : true;
    iconColor = ClipNavigation.currentRoute == widget.route
        ? hoverColor
        : theme.getTheme.textTheme.bodyText1?.color as Color;
    return Expanded(
      child: Padding(
        padding: const EdgeInsets.only(left: 2, right: 2, top: 5, bottom: 0),
        child: InkWell(
          onTap: widget.onPressed,
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
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                mainAxisSize: MainAxisSize.max,
                children: [
                  Expanded(
                    child: IconButton(
                      onPressed: widget.onPressed,
                      icon: Icon(
                        color: onHover ? theme.getTheme.cardColor : iconColor,
                        widget.icon,
                        //color: color ?? Colors.black
                      ),
                      splashRadius: 20,
                    ),
                  ),
                  Visibility(
                    visible: showLabel,
                    child: Expanded(
                        child: Padding(
                      padding: const EdgeInsets.only(top: 7),
                      child: Text(widget.label,
                          style: TextStyle(
                            fontSize: 10.5,
                            color:
                                onHover ? theme.getTheme.cardColor : iconColor,
                          )),
                    )),
                  )
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
