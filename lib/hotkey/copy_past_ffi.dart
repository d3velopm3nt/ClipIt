import 'dart:ffi' as ffi;
import 'dart:io' show Directory;
import 'package:flutter/foundation.dart';
import 'package:path/path.dart' as path;

typedef copy_paste_func = ffi.Void Function();

typedef CopyPaste = void Function();
var releasePath = path.join(Directory.current.path,"data\\flutter_assets");
var debugPath = Directory.current.path;
var libraryPath =
    path.join(kReleaseMode ? releasePath : debugPath, "assets\\libs" ,'WindowsPasteLibrary.dll');

final dll = ffi.DynamicLibrary.open(libraryPath);

final CopyPaste pasteToWindows =
    dll.lookup<ffi.NativeFunction<copy_paste_func>>('paste').asFunction();
