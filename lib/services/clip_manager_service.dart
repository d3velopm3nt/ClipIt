import 'dart:convert';

import 'package:flutter/cupertino.dart';

import '../models/clipitem.model.dart';
import 'datetime_service.dart';
import 'file_service.dart';

class ClipManager extends ChangeNotifier with FileService {
  List<ClipItem> _clips = [];
  List<ClipItem> get clips => _clips;
  List<ClipItem> _filteredList = [];
  List<ClipItem> get filteredList => _filteredList;

  saveClip(String text) async {
    var clip = ClipItem(text, DateTimeService.currentDate);
    clip.id = _clips.length + 1;
    clip.favorite = false;
    clip.tags = [];
    _clips.add(clip);
    await writeFile(jsonEncode(clips));
    _clips = _clips.sortByLatestDate();
    _filteredList = _clips;
    notifyListeners();
  }

  updateClipDate(String text) async {
    clips.firstWhere((clip) => text == clip.copiedText).datetime =
        DateTimeService.currentDate;
    await updateClips();
  }

  updateClipFavorite(ClipItem item) async {
    clips.firstWhere((clip) => clip == item).favorite =
        item.favorite == true ? false : true;
    await updateClips();
  }

  updateClips() async {
    await writeFile(jsonEncode(clips));
    _clips = _clips.sortByLatestDate();
    _filteredList = _clips;
    notifyListeners();
  }

  loadClips() async {
    var clipsText = await readFile();
    if (clipsText == "") return _clips;
    List<dynamic> clipsArr = json.decode(clipsText);
    for (var clip in clipsArr) {
      _clips.add(ClipItem.fromJson(clip));
    }
    _clips = _clips.sortByLatestDate();
    _filteredList = _clips;
    notifyListeners();
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

  ClipItem get latestClip => _clips.sortByLatestDate().first;
}

extension Sorting on List<ClipItem> {
  List<ClipItem> sortByLatestDate() {
    sort((a, b) =>
        DateTime.parse(b.datetime).compareTo(DateTime.parse(a.datetime)));
    return this;
  }
}
