import 'dart:async';

import 'package:flutter/services.dart';
import 'package:flutter_my_clipboard/services/datetime_service.dart';
import 'package:uuid/uuid.dart';

import '../models/cliptag.model.dart';
import '../services/clip_tag_service.dart';

class AppLoadTest {
  static copyToClipboard(String text, int total) async {
   
    for (int i = 0; i < total; i++) {
      ClipboardData data = ClipboardData(text: text + i.toString());
      await Clipboard.setData(data);
      await Future.delayed(const Duration(milliseconds: 300));
    }
  }

  static createTags(ClipTagService tagManager, String text, int total) async {
    await tagManager.loadTags();
    for (int i = 0; i < total; i++) {
      final tag = ClipTag(text + i.toString(), DateTimeService.currentDate, 0,
          const Uuid().v4());
      tagManager.saveTag(tag);
      await Future.delayed(const Duration(milliseconds: 300));
    }
  }
}
