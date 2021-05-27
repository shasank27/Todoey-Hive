import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'task.dart';

class TaskShouter extends ChangeNotifier {
  List<Task> tasks = [];

  int get length {
    return tasks.length;
  }

  void taskDelete(Task task) {
    tasks.remove(task);
    notifyListeners();
  }

  void taskUpdate(Task task) {
    task.reDone();
    notifyListeners();
  }

  void addData(String text) {
    final task = Task(text: text, isDone: false);
    tasks.add(task);
    notifyListeners();
  }
}
