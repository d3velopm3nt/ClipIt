import 'dart:convert';

import '../models/clipitem.model.dart';
import 'datetime_service.dart';
import 'file_service.dart';

class ClipManager with FileService {
  List<ClipItem> clips = [];

  Future<List<ClipItem>> saveClip(String text) async {
    var clip = ClipItem(text, DateTimeService.currentDate);
    clips.add(clip);
    await writeFile(jsonEncode(clips));
    return clips.reversed.toList();
  }

  Future<List<ClipItem>> loadClips() async {
    var clipsText = await readFile();
    if (clipsText == "") return clips;
    List<dynamic> clipsArr = json.decode(clipsText);
    for (var clip in clipsArr) {
      clips.add(ClipItem.fromJson(clip));
    }
    return clips.reversed.toList();
  }
}
