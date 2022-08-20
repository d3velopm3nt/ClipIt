

class ClipItem {
  late String copiedText;
  late String datetime;
  late bool pinned;
  late List<String> tags;

  ClipItem(this.copiedText, this.datetime);

  ClipItem.fromJson(Map<String, dynamic> json)
      : copiedText = json['clipText'],
        datetime = json['datetime'];

  Map toJson() => {
        'clipText': copiedText,
        'datetime': datetime,
      };
}
