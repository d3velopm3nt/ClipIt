import 'package:flutter/material.dart';
import 'package:flutter_my_clipboard/ui/widgets/shared/title_desc_widget.dart';
import 'package:hotkey_manager/hotkey_manager.dart';
import 'package:preference_list/preference_list.dart';
import 'package:provider/provider.dart';
import '../../../services/hotkey_service.dart';

class HotkeysView extends StatefulWidget {
  const HotkeysView({Key? key}) : super(key: key);

  @override
  State<HotkeysView> createState() => _HotkeysViewState();
}

class _HotkeysViewState extends State<HotkeysView> {
  @override
  void initState() {
    super.initState();
  }

  Widget _buildBody(BuildContext context) {
    final hotkeyService = Provider.of<HotKeyService>(context);
    return PreferenceList(
      children: <Widget>[
        PreferenceListSection(
          title: const Text('REGISTERED HOTKEY LIST'),
          children: [
            for (var registeredHotKey in hotkeyService.registeredHotKeyList)
              PreferenceListItem(
                padding: const EdgeInsets.all(12),
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
                await hotkeyService.unregisterAll();
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
