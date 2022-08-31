import 'package:bot_toast/bot_toast.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_my_clipboard/ui/widgets/shared/title_desc_widget.dart';
import 'package:hotkey_manager/hotkey_manager.dart';
import 'package:preference_list/preference_list.dart';

import '../../../services/hotkey_service.dart';
import '../../widgets/shared/record_hotkey_dialog.dart';

class HotkeysView extends StatefulWidget {
  const HotkeysView({Key? key}) : super(key: key);

  @override
  State<HotkeysView> createState() => _HotkeysViewState();
}

class _HotkeysViewState extends State<HotkeysView> {
  List<HotKey> _registeredHotKeyList = [];

  // void _handleHotKeyRegister(HotKey hotKey) async {
  //   await hotKeyManager.register(
  //     hotKey,
  //     keyDownHandler: _keyDownHandler,
  //     keyUpHandler: _keyUpHandler,
  //   );
  //   setState(() {
  //     _registeredHotKeyList = hotKeyManager.registeredHotKeyList;
  //   });
  // }

  // void _handleHotKeyUnregister(HotKey hotKey) async {
  //   await hotKeyManager.unregister(hotKey);
  //   setState(() {
  //     _registeredHotKeyList = hotKeyManager.registeredHotKeyList;
  //   });
  // }

  // Future<void> _handleClickRegisterNewHotKey() async {
  //   return showDialog<void>(
  //     context: context,
  //     barrierDismissible: false,
  //     builder: (BuildContext context) {
  //       return RecordHotKeyDialog(
  //         onHotKeyRecorded: (newHotKey) => _handleHotKeyRegister(newHotKey),
  //       );
  //     },
  //   );
  // }

  Widget _buildBody(BuildContext context) {
    final HotKeyService hotkeyService = HotKeyService();
    return PreferenceList(
      children: <Widget>[
        PreferenceListSection(
          title: Text('REGISTERED HOTKEY LIST'),
          children: [
            for (var registeredHotKey in _registeredHotKeyList)
              PreferenceListItem(
                padding: EdgeInsets.all(12),
                title: Row(
                  children: [
                    const TitleDesc(title: 'Title', description: 'Description'),
                    HotKeyVirtualView(hotKey: registeredHotKey),
                    // SizedBox(width: 10),
                    // Text(
                    //   registeredHotKey.scope.toString(),
                    //   style: TextStyle(
                    //     color: Colors.grey,
                    //     fontSize: 12,
                    //   ),
                    // ),
                  ],
                ),
                accessoryView: SizedBox(
                  width: 40,
                  height: 40,
                  child: CupertinoButton(
                      padding: EdgeInsets.zero,
                      child: Stack(
                        alignment: Alignment.center,
                        children: const [
                          Icon(
                            CupertinoIcons.delete,
                            size: 18,
                            color: Colors.red,
                          ),
                        ],
                      ),
                      onPressed: () =>
                          {} //_handleHotKeyUnregister(registeredHotKey),
                      ),
                ),
              ),
            PreferenceListItem(
              title: Text(
                'Register a new HotKey',
                style: TextStyle(
                  color: Theme.of(context).primaryColor,
                ),
              ),
              accessoryView: Container(),
              onTap: () {
                //_handleClickRegisterNewHotKey();
              },
            ),
          ],
        ),
        PreferenceListSection(
          children: [
            PreferenceListItem(
              title: Text(
                'Unregister all HotKeys',
                style: TextStyle(
                  color: Theme.of(context).primaryColor,
                ),
              ),
              accessoryView: Container(),
              onTap: () async {
                await hotKeyManager.unregisterAll();
                _registeredHotKeyList = hotKeyManager.registeredHotKeyList;
                setState(() {});
              },
            ),
          ],
        ),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    return _buildBody(context);
  }
}
