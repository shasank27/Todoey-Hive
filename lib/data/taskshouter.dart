import 'package:flutter/foundation.dart';
import 'task.dart';

class TaskShouter extends ChangeNotifier {
  List<Task> tasks = [
    Task(text: 'Get eggs', isDone: false),
    Task(text: 'Get bones', isDone: true),
    Task(text: 'Get milk', isDone: false),
  ];

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
