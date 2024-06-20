import 'package:flutter/material.dart';
import 'package:hive/hive.dart';

import '../../app/app.notification.dart';
import 'box_service_interface.dart';
import 'boxes.dart';

class BoxServiceBase<T> extends ChangeNotifier
    implements BoxServiceInterface<T> {
  @override
  late Box box;

  @override
  late String boxName;
  List<T> _list = [];
  @override
  List<T> get list => _list;

  @override
  loadBox() async {
    box = await Hive.openBox<T>(boxName);
    _list = List<T>.from(box.values.toList());
  }

  loadList() async {
     _list = List<T>.from(box.values.toList());
  }

  @override
  Future<void> refresh() async {
    _list = List<T>.from(box.values.toList());
    notifyListeners();
  }

  @override
  Future<void> delete(key) async {
    try {
      key.delete();
      await refresh();
    } catch (ex) {
      AppNotification.errorNotifcation(
          "Error deleting ${T.toString()}", ex.toString());
    }
  }

  @override
  Future<void> save(model) async {
    try {
      //await loadBox();
      //Check if key exists
      if (model.key != null && box.containsKey(model.key)) {
        model.save();
      } else {
        box.add(model);
      }
      await refresh();
    } catch (ex) {
      AppNotification.errorNotifcation(
          "Error saving ${model.toString()}", ex.toString());
    }
  }

  @override
  Future<void> update(model) async {
    try {
      await loadBox();
      model.save();
      await refresh();
    } catch (ex) {
      AppNotification.errorNotifcation(
          "Error updating ${model.toString()}", ex.toString());
    }
  }

  @override
  Future<void> deleteAll() async {
    await box.deleteFromDisk();
    _list = [];
    notifyListeners();
  }
}
