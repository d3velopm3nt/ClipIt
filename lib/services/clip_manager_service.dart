import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_my_clipboard/services/box/boxes.dart';
import 'package:hive_flutter/adapters.dart';
import '../app/app.notification.dart';
import '../models/clipitem.model.dart';
import '../settings/services/settings_service.dart';
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
      clipBox = Boxes.clipsBox;
    // if (!Hive.isBoxOpen(clipBoxName)) {
    //     clipBox = await Hive.openBox<ClipItem>(clipBoxName);
    // }

    _clips = List<ClipItem>.from(clipBox.values.toList());
  }

  Future<bool> deleteClips() async {
    var list = _clips.where((c) => c.tags.isEmpty == true);
    for (var clip in list) {
      await clip.delete();
    }

    await refreshClips();
    AppNotification.deleteNotifcation(
        'All Clips Deleted', "Now you need to copy everything again");

    return true;
  }

  refreshClips() async {
    await loadClipBox();
    _filteredList = _clips.sortByLatestDate();
    notifyListeners();
  }

  saveClip(String text, {SettingsService? settings}) async {
    var clip = ClipItem(
        text, DateTimeService.currentDate, false, [], _clips.length + 1, false);
    //Add to Hive Box
    if (clipBox.containsKey(clip.key)) {
      clip.save();
    } else {
      clipBox.add(clip);
    }
    await refreshClips();

    // Archive old clips if settings provided and limit exceeded
    if (settings != null) {
      await archiveOldClips(settings);
    }
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

  ClipItem? getClipById(String id) {
    //await loadClipBox();
    var clip = _clips.where((c) => c.id.toString() == id);
    return clip.isNotEmpty ? clip.first : null;
  }

  // Archive functionality
  Future<void> archiveOldClips(SettingsService settings) async {
    final maxActive = settings.appSettings.maxActiveClips;
    if (_clips.length <= maxActive) return;

    // Sort clips by date (newest first) and get clips to archive
    final sortedClips = _clips.sortByLatestDate();
    final clipsToArchive = sortedClips.skip(maxActive).toList();

    if (clipsToArchive.isEmpty) return;

    // Move clips to archive box
    final archiveBox = Boxes.archiveBox;
    for (var clip in clipsToArchive) {
      // Remove from active clips
      await clip.delete();
      // Add to archive with string key based on ID
      await archiveBox.put(clip.id.toString(), clip);
    }

    await refreshClips();
    AppNotification.infoNotification(
      'Clips Archived',
      '${clipsToArchive.length} old clips moved to archive'
    );
  }

  List<ClipItem> getArchivedClips() {
    final archiveBox = Boxes.archiveBox;
    return List<ClipItem>.from(archiveBox.values.toList()).sortByLatestDate();
  }

  Future<void> restoreClip(ClipItem archivedClip) async {
    // Remove from archive
    final archiveBox = Boxes.archiveBox;
    await archiveBox.delete(archivedClip.id.toString());

    // Add back to active clips (let Hive assign new key)
    await clipBox.add(archivedClip);

    await refreshClips();
    AppNotification.infoNotification(
      'Clip Restored',
      'Archived clip restored to active clips'
    );
  }

  Future<void> deleteArchivedClip(ClipItem archivedClip) async {
    final archiveBox = Boxes.archiveBox;
    await archiveBox.delete(archivedClip.id.toString());
    AppNotification.deleteNotifcation(
      'Archived Clip Deleted',
      'Clip permanently removed from archive'
    );
  }

  List<ClipItem> getByDate(DateTime date) {
    var filtered = _clips.where((element) =>
        DateTimeService.getDate(element.datetime) ==
        DateTimeService.getDate(date.toString()));
    return filtered.toList();
  }

  List<ClipItem> getByMonth(int month) {
    var filtered = _clips
        .where((element) => DateTime.parse(element.datetime).month == month);
    return filtered.toList();
  }

  List<ClipItem> getByDateRange(DateTime fromDate, DateTime toDate) {
    var filtered;
    for (var i = 0; i < clips.length; i++) {
      DateTime date = DateTime.parse(clips[i].datetime);
      if (date.compareTo(fromDate) <= 0 && date.compareTo(toDate) <= 0) {
        filtered.add(clips[i]);
      }
    }
    return filtered.toList();
  }

  searchClips(String searchText) async {
    _filteredList = _clips
        .where((x) =>
            x.copiedText.toLowerCase().contains(searchText.toLowerCase()))
        .toList();
    notifyListeners();
  }

  List<ClipItem> _filteredArchivedClips = [];

  searchArchivedClips(String searchText) async {
    if (searchText.isEmpty) {
      _filteredArchivedClips = getArchivedClips();
    } else {
      _filteredArchivedClips = getArchivedClips()
          .where((x) =>
              x.copiedText.toLowerCase().contains(searchText.toLowerCase()))
          .toList();
    }
    notifyListeners();
  }

  List<ClipItem> getFilteredArchivedClips() {
    return _filteredArchivedClips;
  }
}

extension Sorting on List<ClipItem> {
  List<ClipItem> sortByLatestDate() {
    sort((a, b) =>
        DateTime.parse(b.datetime).compareTo(DateTime.parse(a.datetime)));
    return this;
  }
}
