import 'package:flutter/material.dart';
import 'package:hive/hive.dart';

import '../../app/app.notification.dart';
import 'box_service_interface.dart';

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

  @override
  Future<void> refresh() async {
    await loadBox();
    notifyListeners();
  }

  @override
  Future<void> delete(T) async {
    try{
    T.delete();
   await loadBox();
    } catch (ex) {
      AppNotification.errorNotifcation(
          "Error deleting ${T.toString()}", ex.toString());
    }
  }

  @override
  Future<void> save(T) async {
    try {
      //Check if key exists
      if (T.key != null && T.containsKey(T.key)) {
        T.save();
      } else {
        box.add(T);
      }
      await loadBox();
    } catch (ex) {
      AppNotification.errorNotifcation(
          "Error saving ${T.toString()}", ex.toString());
    }
  }

  @override
  Future<void> update(T) async {
   try{
    T.save();
   await loadBox();
    } catch (ex) {
      AppNotification.errorNotifcation(
          "Error updating ${T.toString()}", ex.toString());
    }
  }
}
