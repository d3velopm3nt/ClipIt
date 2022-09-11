import 'package:flutter/material.dart';
import 'package:hotkey_manager/hotkey_manager.dart';

class RecordHotKeyDialog extends StatefulWidget {
  final Function(HotKey, String) onHotKeyRecorded;

  const RecordHotKeyDialog({
    Key? key,
    required this.onHotKeyRecorded,
  }) : super(key: key);

  @override
  _RecordHotKeyDialogState createState() => _RecordHotKeyDialogState();
}

class _RecordHotKeyDialogState extends State<RecordHotKeyDialog> {
  HotKey? _hotKey;
  final titleControl = TextEditingController();
  bool titleSelected = true;
  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      // title: Text('Rewind and remember'),
      content: SingleChildScrollView(
        child: ListBody(
          children: <Widget>[
            const Text('Press the keys you want to use'),
            TextField(
                onTap: () {
                  setState(() {
                    titleSelected = true;
                  });
                },
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
              width: 100,
              height: 60,
              margin: const EdgeInsets.only(top: 20),
              decoration: BoxDecoration(
                border: Border.all(
                  color: Theme.of(context).primaryColor,
                ),
              ),
              child: Stack(
                alignment: Alignment.center,
                children: [
                  GestureDetector(
                    onTap: () {
                      setState(() {
                        titleSelected = false;
                      });
                    },
                    child: HotKeyRecorder(
                      onHotKeyRecorded: (hotKey) {
                        _hotKey = hotKey;
                      },
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
      actions: <Widget>[
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
}
