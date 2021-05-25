import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:todoey_flutter/data/taskshouter.dart';

class TaskTile extends StatelessWidget {
  final bool isChecked;
  final String taskTitle;
  final Function toggleCheckBox;
  final Function deleteonLongPress;

  TaskTile(
      {this.isChecked,
      this.taskTitle,
      this.toggleCheckBox,
      this.deleteonLongPress});

  @override
  Widget build(BuildContext context) {
    return ListTile(
      onLongPress: deleteonLongPress,
      leading: Text(
        taskTitle,
        style: TextStyle(
          fontSize: 20,
          decoration: isChecked ? TextDecoration.lineThrough : null,
        ),
      ),
      trailing: Checkbox(
        value: isChecked,
        activeColor: Colors.lightBlueAccent,
        onChanged: toggleCheckBox,
      ),
    );
  }
}
