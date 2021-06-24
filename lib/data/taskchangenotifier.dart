import 'package:flutter/cupertino.dart';
import 'package:hive/hive.dart';
import 'package:uuid/uuid.dart';
import 'package:todoey_flutter/data/task.dart';

class TaskChangeNotifier extends ChangeNotifier {
  void delete(var uid) async {
    List box = Hive.box('todolist').values.toList();
    int count = 0;
    for (var i in box) {
      if (i.uuid == uid) {
        break;
      }
      count++;
    }
    await Hive.box('todolist').deleteAt(count);
    notifyListeners();
  }

  List<TaskModel> getDone() {
    return Hive.box('todolist')
        .values
        .where((element) => element.isDone == false)
        .map<TaskModel>((e) => e)
        .toList();
  }

  List<TaskModel> getNotDone() {
    return Hive.box('todolist')
        .values
        .where((element) => element.isDone == true)
        .map<TaskModel>((e) => e)
        .toList();
  }

  void add(String string) async {
    await Hive.box('todolist')
        .add(TaskModel(text: string, isDone: false, uuid: Uuid().v1()));
    notifyListeners();
  }

  void put(var uid) async {
    List box = Hive.box('todolist').values.toList();
    int count = 0;
    for (var i in box) {
      if (i.uuid == uid) {
        break;
      }
      count++;
    }
    var hive = Hive.box('todolist');
    await hive.putAt(
      count,
      TaskModel(
        text: hive.getAt(count).text,
        isDone: !hive.getAt(count).isDone,
        uuid: hive.getAt(count).uuid,
      ),
    );
    notifyListeners();
  }

  int get tasklength {
    return Hive.box('todolist')
        .values
        .where((element) => element.isDone == false)
        .length;
  }
}
