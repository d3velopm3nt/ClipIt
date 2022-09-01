import 'package:flutter/material.dart';

import '../../../navigation/navigation_manager.dart';

class PageWidget extends StatefulWidget {
  const PageWidget({Key? key}) : super(key: key);

  @override
  State<PageWidget> createState() => _PageWidgetState();
}

class _PageWidgetState extends State<PageWidget> {
   final navigation = NavigationManager();
  @override
  void initState() {

WidgetsBinding.instance.endOfFrame.then((_) {
      navigation.pageLoading(false);
    });

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Container();
  }
}
