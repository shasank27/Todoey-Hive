import 'package:flutter/cupertino.dart';
import 'package:hive/hive.dart';
import 'package:todoey_flutter/data/task.dart';

class TaskChangeNotifier extends ChangeNotifier {
  void delete(int index) async {
    await Hive.box('todolist').deleteAt(index);
    notifyListeners();
  }

  void add(String string) async {
    await Hive.box('todolist').add(TaskModel(text: string, isDone: false));
    notifyListeners();
  }

  void put(int index, bool value) async {
    var hive = Hive.box('todolist');
    // print("\n" + hive.getAt(index).text);
    // print(hive.getAt(index).isDone);
    // print(index);
    await hive.putAt(
      index,
      TaskModel(
        text: await hive.getAt(index).text,
        isDone: !value,
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
