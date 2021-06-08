import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:hive/hive.dart';
import 'package:todoey_flutter/data/task.dart';
import 'task_tile.dart';

class TaskList extends StatefulWidget {
  @override
  _TaskListState createState() => _TaskListState();
}

class _TaskListState extends State<TaskList> {
  final buildtasklist = Hive.box('todolist');
  @override
  void initState() {
    //Hive.registerAdapter<TaskModel>(TaskModelAdapter());
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: buildtasklist.length,
      itemBuilder: (context, index) {
        return TaskTile(
          isChecked: buildtasklist.get(index).isDone,
          taskTitle: buildtasklist.get(index).text,
          toggleCheckBox: () {
            //buildtasklist.get(index).reDone;
          },
          deleteonLongPress: () {
            //buildtasklist.get(index).delete;
          },
        );
      },
    );
  }
}
