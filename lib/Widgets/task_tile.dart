import 'package:flutter/material.dart';

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
      title: Text(
        taskTitle,
        textAlign: TextAlign.justify,
        style: TextStyle(
        color: Theme.of(context).primaryColor,
        fontSize: 20,
        decoration: isChecked ? TextDecoration.lineThrough : null,
              ),
      ),
      trailing: Container(
        padding: EdgeInsets.all(2),
              child: Checkbox(
          value: isChecked,
          fillColor: MaterialStateProperty.all(Theme.of(context).disabledColor),
          checkColor: Theme.of(context).canvasColor,
          onChanged: toggleCheckBox,
        ),
      ),
    );
  }
}
