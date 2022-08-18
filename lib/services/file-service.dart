import 'dart:io';

class FileService {
  final String _localPath = "C://clips/";
  final String _newLine = "--------------------------------------";
  String get _currentDate {
    DateTime now = DateTime.now();
    String convertedDateTime =
        "${now.year.toString()}-${now.month.toString().padLeft(2, '0')}-${now.day.toString().padLeft(2, '0')} ${now.hour.toString().padLeft(2, '0')}:${now.minute.toString().padLeft(2, '0')}:${now.second.toString().padLeft(2, '0')}";
    return convertedDateTime;
  }

  Future<File> get _localFile {
    final path = _localPath;
    var fileName = '$path/myclips.txt';
    // dynamic newFile;
    // if(await File(fileName).exists()){
    //  newFile = File(fileName);
    // }
    return File(fileName).create(recursive: true);
  }

  Future<void> saveText(String text) async {
    var file = await _localFile;
    var sink = file.openWrite(mode: FileMode.append);
    sink.write("$_currentDate | $text\n$_newLine\n");
    await sink.flush();
    await sink.close();
  }
}
