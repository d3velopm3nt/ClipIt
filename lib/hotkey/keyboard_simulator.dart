import 'package:flutter/cupertino.dart';
import 'package:flutter/services.dart';
import 'package:flutter/src/foundation/diagnostics.dart';

class KeyboardSimulator {
  static simulatePaste() async {
    KeyDownEvent controlDown = const KeyDownEvent(
        physicalKey: PhysicalKeyboardKey.controlLeft,
        logicalKey: LogicalKeyboardKey.controlLeft,
        synthesized: true,
        timeStamp: Duration(milliseconds: 100));
    HardwareKeyboard.instance.handleKeyEvent(controlDown);

    KeyDownEvent vKeyDown = const KeyDownEvent(
        physicalKey: PhysicalKeyboardKey.keyV,
        logicalKey: LogicalKeyboardKey.keyV,
        synthesized: true,
        timeStamp: Duration(milliseconds: 100));
    HardwareKeyboard.instance.handleKeyEvent(vKeyDown);
    Future.delayed(const Duration(milliseconds: 100));
    KeyUpEvent controlUp = const KeyUpEvent(
        physicalKey: PhysicalKeyboardKey.controlLeft,
        logicalKey: LogicalKeyboardKey.controlLeft,
        synthesized: true,
        timeStamp: Duration(milliseconds: 100));
    HardwareKeyboard.instance.handleKeyEvent(controlUp);

    KeyUpEvent vKeyUp = const KeyUpEvent(
        physicalKey: PhysicalKeyboardKey.keyV,
        logicalKey: LogicalKeyboardKey.keyV,
        synthesized: true,
        timeStamp: Duration(milliseconds: 100));
    HardwareKeyboard.instance.handleKeyEvent(vKeyUp);
  }

  static RawKeyEventDataWindows ctrlData =
      const RawKeyEventDataWindows(keyCode: 162, scanCode: 29, modifiers: 24,characterCodePoint: 0);
  static RawKeyEventDataWindows vData =
      const RawKeyEventDataWindows(keyCode: 86, scanCode: 47, modifiers: 0,characterCodePoint:118);

  static simulate() {
    RawKeyboard.instance.addListener((value) {
      print(value);
    });
    RawKeyboard.instance.handleRawKeyEvent(RawKeyDownEvent(data: ctrlData));

    RawKeyboard.instance.handleRawKeyEvent(RawKeyDownEvent(
        data: vData ));

    var keys = RawKeyboard.instance.keysPressed;

    // RawKeyboard.instance.handleRawKeyEvent(RawKeyUpEvent(
    //     data: ctrlData ));

    // RawKeyboard.instance.handleRawKeyEvent(RawKeyUpEvent(
    //     data: vData));
  }
}

class KeyboardEvent extends KeyEvent {
  KeyboardEvent(
      {required super.physicalKey,
      required super.logicalKey,
      required super.timeStamp});
}
