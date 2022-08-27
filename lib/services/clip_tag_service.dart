import 'package:flutter/material.dart';
import 'package:flutter_my_clipboard/app/app-notification.dart';
import 'package:hive/hive.dart';
import 'package:provider/provider.dart';

import '../models/cliptag.model.dart';

class ClipTagService extends ChangeNotifier {
  List<ClipTag> _tags = [];
  String tagBoxName = "tagBox";
  late Box tagBox;
  List<ClipTag> get tags => _tags;

  loadTags() async {
    if (!Hive.isBoxOpen(tagBoxName)) {
      tagBox = await Hive.openBox<ClipTag>(tagBoxName);
    }

    _tags = List<ClipTag>.from(tagBox.values.toList());

    notifyListeners();
  }

  Future<bool> saveTag(ClipTag tag) async {
    try {
      if (tag.key != null && tagBox.containsKey(tag.key)) {
        tag.save();
      } else {
        tagBox.add(tag);
      }
      await loadTags();

      return true;
    } catch (error) {
      return false;
    }
  }

  ClipTag? getTagById(String id) {
    try {
      var tags = _tags.where((element) => element.id == id);
      return tags.first;
    } catch (error) {
      return null;
    }
  }

  deleteTags() async {
 await tagBox.clear();
  }

  deleteTag(ClipTag tag) async {
    await tag.delete();
    await loadTags();
    AppNotification.deleteNotifcation(
        "Tag Deleted", "tag will be removed from all clips");
  }
}
