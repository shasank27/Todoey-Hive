import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';
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
  Widget build(BuildContext context) {
    return ValueListenableBuilder(
        valueListenable: Hive.box('todolist').listenable(),
        builder: (context, value, _) {
          return ListView.builder(
            itemCount: buildtasklist.length,
            itemBuilder: (context, index) {
              return TaskTile(
                isChecked: buildtasklist.getAt(index).isDone,
                taskTitle: buildtasklist.getAt(index).text,
                toggleCheckBox: (value) {
                  buildtasklist.putAt(
                    index,
                    TaskModel(
                      text: buildtasklist.getAt(index).text,
                      isDone: buildtasklist.getAt(index).isDone ? false : true,
                    ),
                  );
                },
                deleteonLongPress: () {
                  buildtasklist.deleteAt(index);
                },
              );
            },
          );
        });
  }
}
