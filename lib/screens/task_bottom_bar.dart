import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:todoey_flutter/data/task.dart';

class TaskScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    String newTask;
    return Container(
      padding: EdgeInsets.only(top: 30, right: 30, left: 30),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(30),
          topRight: Radius.circular(30),
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Text(
            'Add Task',
            textAlign: TextAlign.center,
            style: TextStyle(
              color: Theme.of(context).disabledColor,
              fontSize: 30.0,
            ),
          ),
          TextField(
            style: TextStyle(color: Theme.of(context).primaryColor),
            decoration: InputDecoration(
              enabledBorder: UnderlineInputBorder(
                borderSide: BorderSide(color: Theme.of(context).disabledColor),
              ),
              focusedBorder: UnderlineInputBorder(
                borderSide: BorderSide(color: Theme.of(context).disabledColor),
              ),
            ),
            cursorColor: Theme.of(context).disabledColor,
            onChanged: (String value) {
              newTask = value;
            },
            autofocus: true,
          ),
          SizedBox(
            height: 10,
          ),
          TextButton(
            onPressed: () {
              Hive.box('todolist').add(TaskModel(text: newTask, isDone: false));
              Navigator.pop(context);
            },
            child: Text(
              'Add',
              style: TextStyle(color: Colors.white, fontSize: 15),
            ),
          ),
        ],
      ),
    );
  }
}
