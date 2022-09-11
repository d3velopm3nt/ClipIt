import 'package:flutter/material.dart';
import 'package:flutter_my_clipboard/ui/widgets/shared/hotkey_item.dart';
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
            for (var model in hotkeyService.list)
            HotKeyItem(model: model)
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
