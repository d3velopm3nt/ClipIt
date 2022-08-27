import 'package:flutter/material.dart';
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
      //tagBox.deleteFromDisk();
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

  ClipTag getTagById(String id) {
    var tag = _tags.where((element) => element.id == id);

    return tag.first;
  }
}
