import 'package:flutter/material.dart';
import 'package:flutter_my_clipboard/models/hotkey.model.dart';
import 'package:hotkey_manager/hotkey_manager.dart';
import 'package:provider/provider.dart';

import '../../../services/hotkey_service.dart';
import 'confirm_dialog.dart';

class RecordHotKeyDialog extends StatefulWidget {
  final Function(HotKey, String) onHotKeyRecorded;
  final HotKeyModel? hotkey;

  const RecordHotKeyDialog({
    Key? key,
    required this.onHotKeyRecorded,
    this.hotkey,
  }) : super(key: key);

  @override
  _RecordHotKeyDialogState createState() => _RecordHotKeyDialogState();
}

class _RecordHotKeyDialogState extends State<RecordHotKeyDialog> {
  HotKey? _hotKey;
  final titleControl = TextEditingController();
  HotKeyService service = HotKeyService();
  @override
  Widget build(BuildContext context) {
    service = Provider.of<HotKeyService>(context);
    if (widget.hotkey != null) {
      _hotKey = service.buildHotKey(widget.hotkey as HotKeyModel);
      titleControl.text = widget.hotkey?.title as String;
    }
    return AlertDialog(
      // title: Text('Rewind and remember'),
      content: SingleChildScrollView(
        child: ListBody(
          children: <Widget>[
            const Padding(
              padding: EdgeInsets.all(8.0),
              child: Text('Press the keys you want to use'),
            ),
            TextField(
                controller: titleControl,
                decoration: const InputDecoration(
                    labelText: "Title",
                    prefixIcon: Icon(Icons.label),
                    border: OutlineInputBorder(
                        //Outline border type for TextFeild
                        borderRadius: BorderRadius.all(Radius.circular(10)),
                        borderSide: BorderSide(
                          color: Color.fromARGB(255, 104, 99, 99),
                          width: 3,
                        )))),
            Container(
              width: 250,
              height: 80,
              margin: const EdgeInsets.only(top: 20),
              decoration: BoxDecoration(
                border: Border.all(
                  color: Theme.of(context).primaryColor,
                ),
              ),
              child: Stack(
                alignment: Alignment.center,
                children: [
                  HotKeyRecorder(
                    initalHotKey: _hotKey,
                    onHotKeyRecorded: (hotKey) {
                      setState(() {
                        _hotKey = hotKey;
                      });
                    },
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
      actions: <Widget>[
        Visibility(
          visible: widget.hotkey != null,
          child: TextButton(
            style: ButtonStyle(
                backgroundColor: MaterialStateProperty.all(Colors.red)),
            child: const Text('Remove',
                style: TextStyle(
                    fontWeight: FontWeight.w600, color: Colors.white)),
            onPressed: () {
              _delete(context);
            },
          ),
        ),
        TextButton(
          child: const Text('Cancel'),
          onPressed: () {
            Navigator.of(context).pop();
          },
        ),
        TextButton(
          onPressed: _hotKey == null
              ? null
              : () {
                  widget.onHotKeyRecorded(_hotKey!, titleControl.text);
                  Navigator.of(context).pop();
                },
          child: const Text('OK'),
        ),
      ],
    );
  }

  void _delete(BuildContext context) {
    showDialog(
        context: context,
        builder: (BuildContext ctx) {
          return ConfirmDailog(
              question: 'Do you want to remove the hot key?',
              onConfirm: (confirm) async => {
                    if (confirm)
                      {
                        service.delete(widget.hotkey),
                        Navigator.of(context).pop()
                      }
                  });
        });
  }
}
