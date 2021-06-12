import 'package:flutter/cupertino.dart';
import 'package:hive/hive.dart';
import 'package:todoey_flutter/data/task.dart';

class TaskChangeNotifier extends ChangeNotifier {
  void delete(int index) {
    Hive.box('todolist').deleteAt(index);
    notifyListeners();
  }

  void add(String string) {
    Hive.box('todolist').add(TaskModel(text: string, isDone: false));
    notifyListeners();
  }

  void put(int index) async {
    notifyListeners();
  }

  int get tasklength {
    return Hive.box('todolist')
        .values
        .where((element) => element.isDone == false)
        .length;
  }
}