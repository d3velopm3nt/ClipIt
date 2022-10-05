import 'package:flutter/material.dart';
import 'package:flutter_my_clipboard/ui/widgets/shared/hotkey_item.dart';
import 'package:preference_list/preference_list.dart';
import 'package:provider/provider.dart';
import '../../../services/hotkey_service.dart';
import '../shared/no_results_view.dart';

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
    return Column(
      children: [
         Visibility(
                visible: hotkeyService.list.isEmpty,
                child: Expanded(
                  child: NoResultsView(
                      image: "intro/hotkey.png",
                      title: "No Hotkeys Created",
                      description:
                          "To assign a shortcut click the menu on any of the clippets and select Hot key"),
                ),
              ),
        Visibility(
          visible: hotkeyService.list.isNotEmpty,
          child: Expanded(
            child: PreferenceList(
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
            ),
          ),
        ),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    return _buildBody(context);
  }
}
