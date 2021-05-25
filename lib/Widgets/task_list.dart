import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:todoey_flutter/data/taskshouter.dart';
import 'task_tile.dart';

class TaskList extends StatefulWidget {
  @override
  _TaskListState createState() => _TaskListState();
}

class _TaskListState extends State<TaskList> {
  @override
  Widget build(BuildContext context) {
    return Consumer<TaskShouter>(
      builder: (context, taskShouter, child) {
        return ListView.builder(
          itemBuilder: (context, index) {
            return TaskTile(
              isChecked: taskShouter.tasks[index].isDone,
              taskTitle: taskShouter.tasks[index].text,
              toggleCheckBox: (value) {
                taskShouter.taskUpdate(taskShouter.tasks[index]);
              },
              deleteonLongPress: () {
                Provider.of<TaskShouter>(context, listen: false)
                    .taskDelete(taskShouter.tasks[index]);
              },
            );
          },
          itemCount: taskShouter.length,
        );
      },
    );
  }
}
