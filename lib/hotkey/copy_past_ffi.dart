import 'dart:ffi' as ffi;
import 'dart:io' show Directory, File;
import 'package:flutter/foundation.dart';
import 'package:path/path.dart' as path;

typedef CopyPasteFunc = ffi.Void Function();

typedef CopyPaste = void Function();
// Get the path to the Windows paste library
String getLibraryPath() {
  if (kReleaseMode) {
    // In release mode, the DLL should be in the same directory as the executable
    return 'WindowsPasteLibrary.dll';
  } else {
    // In debug mode, try multiple possible locations
    final possiblePaths = [
      'assets/libs/WindowsPasteLibrary.dll',  // From project root when running flutter run
      'data/flutter_assets/assets/libs/WindowsPasteLibrary.dll',  // Flutter's asset path
      path.join(Directory.current.path, 'assets', 'libs', 'WindowsPasteLibrary.dll'),
    ];

    for (final possiblePath in possiblePaths) {
      if (File(possiblePath).existsSync()) {
        return possiblePath;
      }
    }

    // Fallback to the most likely debug path
    return path.join(Directory.current.path, 'assets', 'libs', 'WindowsPasteLibrary.dll');
  }
}

var libraryPath = getLibraryPath();

final dll = ffi.DynamicLibrary.open(libraryPath);

final CopyPaste pasteToWindows =
    dll.lookup<ffi.NativeFunction<CopyPasteFunc>>('paste').asFunction();
