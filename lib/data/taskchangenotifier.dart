import 'package:flutter/cupertino.dart';
import 'package:hive/hive.dart';
import 'package:uuid/uuid.dart';
import 'package:todoey_flutter/data/task.dart';

class TaskChangeNotifier extends ChangeNotifier {
  void delete(var uid) async {
    List<TaskModel> index =
        Hive.box('todolist').values.where((element) => element.uuid == uid);
  
  //  await Hive.box('todolist').
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
    var hive = Hive.box('todolist');
    List<TaskModel> index =
        Hive.box('todolist').values.map<TaskModel>((e) => e).toList(); //where((element) => element.uuid == uid);
    
    // print("\n" + hive.getAt(index).text);
    // print(hive.getAt(index).isDone);
    // print(index);
    // await hive.putAt(
    //   // index,
    //   // TaskModel(
    //   //   text: await hive.getAt(index).text,
    //   //   isDone: !value,
    //  // ),
    // );
    notifyListeners();
  }

  int get tasklength {
    return Hive.box('todolist')
        .values
        .where((element) => element.isDone == false)
        .length;
  }
}
