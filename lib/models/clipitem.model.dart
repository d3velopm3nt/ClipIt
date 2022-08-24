class ClipItem {
  late int id;
  late String copiedText;
  late String datetime;
  late bool favorite = false;
  late List<String> tags;

  ClipItem(this.copiedText, this.datetime);

  ClipItem.fromJson(Map<String, dynamic> json)
      : id = json['id'], 
      copiedText = json['clipText'],
        datetime = json['datetime'],
        favorite = json['favorite'] ,
        tags = json['tags'];

  Map toJson() => {
        'id': id,
        'clipText': copiedText,
        'datetime': datetime,
        'favorite': favorite,
        'tags': tags
      };
}
