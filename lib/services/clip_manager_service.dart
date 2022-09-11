import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:hive_flutter/adapters.dart';
import '../app/app.notification.dart';
import '../models/clipitem.model.dart';
import 'datetime_service.dart';

class ClipManager extends ChangeNotifier {
  List<ClipItem> _clips = [];
  List<ClipItem> get clips => _clips;
  List<ClipItem> _filteredList = [];
  List<ClipItem> get filteredList => _filteredList;
  late Box clipBox;
  final clipBoxName = "clipBox";

  ClipItem get latestClip => _clips.sortByLatestDate().first;

  loadClipBox() async {
    //if (!Hive.isBoxOpen(clipBoxName)) {
    clipBox = await Hive.openBox<ClipItem>(clipBoxName);
    // }

    _clips = List<ClipItem>.from(clipBox.values.toList());
  }

  deleteClips() async {
    await clipBox.clear();

    await refreshClips();
    AppNotification.deleteNotifcation(
        'All Clips Deleted', "Now you need to copy everything again");
  }

  refreshClips() async {
    await loadClipBox();
    _filteredList = _clips.sortByLatestDate();
    notifyListeners();
  }

  saveClip(String text) async {
    var clip = ClipItem(
        text, DateTimeService.currentDate, false, [], _clips.length + 1,false);
    //Add to Hive Box
    if (clipBox.containsKey(clip.key)) {
      clip.save();
    } else {
      clipBox.add(clip);
    }
    await refreshClips();
  }

  updateClipDate(String text) async {
    var clip = clips.firstWhere((clip) => text == clip.copiedText);
    clip.datetime = DateTimeService.currentDate;
    clip.save();
    await refreshClips();
  }

  updateClip(ClipItem item) async {
    item.save();
    await refreshClips();
    AppNotification.infoNotification('Clip Updated', "");
  }

  deleteClip(ClipItem item) async {
    item.delete();
    await refreshClips();
    AppNotification.deleteNotifcation(
        'Clip Deleted', "You should not see this anymore");
  }

  removeClipTags(String id) async {
    var clips = _clips.where((c) => c.tags.contains(id));
    for (var clip in clips) {
      clip.tags.remove(id);
      await clip.save();
    }
  }

  loadClips() async {
    await refreshClips();
  }

  ClipItem getClipById(String id)  {
    //await loadClipBox();
    var clip = _clips.where((c) => c.id.toString() == id);
    return clip.first;
  }

  List<ClipItem> getByDate(DateTime date) {
    var filtered = _clips.where((element) =>
        DateTimeService.getDate(element.datetime) ==
        DateTimeService.getDate(date.toString()));
    return filtered.toList();
  }

  searchClips(String searchText) async {
    _filteredList = _clips
        .where((x) =>
            x.copiedText.toLowerCase().contains(searchText.toLowerCase()))
        .toList();
    notifyListeners();
  }
}

extension Sorting on List<ClipItem> {
  List<ClipItem> sortByLatestDate() {
    sort((a, b) =>
        DateTime.parse(b.datetime).compareTo(DateTime.parse(a.datetime)));
    return this;
  }
}
