import 'package:hive_flutter/hive_flutter.dart';

abstract class BoxServiceInterface<T> {
  late Box box;
  late String boxName;
  List<T> get list;
  Future<void> loadBox();
  Future<void> refresh();
  Future<void> save(T);
  Future<void> update(T);
  Future<void> delete(T);
  Future<void> deleteAll();
}
