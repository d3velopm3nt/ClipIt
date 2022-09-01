import 'package:flutter/material.dart';
import 'package:flutter_my_clipboard/app/app.notification.dart';
import 'package:flutter_my_clipboard/main.dart';
import 'package:hive/hive.dart';
import '../models/cliptag.model.dart';

class ClipTagService extends ChangeNotifier {
  List<ClipTag> _tags = [];
  String tagBoxName = "tagBox";
  late Box tagBox;
  List<ClipTag> get tags => _tags;

  loadTags() async {
    if (!Hive.isBoxOpen(tagBoxName)) {
      tagBox = await Hive.openBox<ClipTag>(tagBoxName);
      // await deleteTags();
    }

    _tags = List<ClipTag>.from(tagBox.values.toList());

    notifyListeners();
  }

  Future<bool> saveTag(ClipTag tag) async {
    try {
      //Check if tag label exists
      if (_tags.any((t) => t.label == tag.label)) {
        AppNotification.warningNotification("Tag lable already exists",
            "Please change the label and try again");
        return false;
      }

      //Check if tag exists
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

  ClipTag getTagById(String id) {
    var tags = _tags.where((element) => element.id == id);
    return tags.first;
  }

  deleteTags() async {
    await tagBox.clear();
    AppNotification.deleteNotifcation(
        "All Tags Deleted", "There will be no more tags on your clipboard");
  }

  deleteTag(ClipTag tag) async {
    await tag.delete();
    await loadTags();
    AppNotification.deleteNotifcation(
        "Tag Deleted", "tag will be removed from all clips");
  }
}
