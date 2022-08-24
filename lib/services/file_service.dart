import 'dart:io';

mixin FileService {
  final String _localPath = "C://Clip It/";

  Future<File> get _localFile {
    final path = _localPath;
    var fileName = '$path/myclips.json';
    return File(fileName).create(recursive: true);
  }

  Future<void> writeFile(String text) async {
    var file = await _localFile;
    file.writeAsStringSync(text);
  }

  Future<String> readFile() async {
    try {
      final file = await _localFile;
      return await file.readAsString();
    } catch (e) {
      return e.toString();
    }
  }
}
