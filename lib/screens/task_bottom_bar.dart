import 'package:flutter/material.dart';
import 'package:todoey_flutter/data/taskshouter.dart';
import 'package:todoey_flutter/data/task.dart';
import 'package:provider/provider.dart';

class TaskScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    String newTask;
    return Container(
      padding: EdgeInsets.only(top: 30, right: 30, left: 30),
      decoration: BoxDecoration(
        color: Colors.white,
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
              color: Colors.lightBlueAccent,
              fontSize: 30.0,
            ),
          ),
          TextField(
            onChanged: (String value) {
              newTask = value;
            },
            autofocus: true,
          ),
          SizedBox(
            height: 10,
          ),
          TextButton(
            style: ButtonStyle(
                backgroundColor:
                    MaterialStateProperty.all(Colors.lightBlueAccent)),
            onPressed: () {
              Provider.of<TaskShouter>(context, listen: false).addData(newTask);
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
