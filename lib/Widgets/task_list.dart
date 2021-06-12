import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:hive/hive.dart';
import 'package:rflutter_alert/rflutter_alert.dart';
import 'package:provider/provider.dart';
import 'package:todoey_flutter/data/task.dart';
import 'package:todoey_flutter/data/taskchangenotifier.dart';
import 'package:todoey_flutter/screens/task_screen.dart';
import 'task_tile.dart';

class TaskList extends StatefulWidget {
  @override
  _TaskListState createState() => _TaskListState();
}

class _TaskListState extends State<TaskList> {
  TaskChangeNotifier taskChangeNotifier;
  final buildtasklist = Hive.box('todolist');
  TasksScreen task;
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
                  Alert(
                    style: AlertStyle(
                        backgroundColor: Theme.of(context).canvasColor,
                        titleStyle: TextStyle(
                          color: Theme.of(context).primaryColor,
                        ),
                        descStyle: TextStyle(
                          color: Theme.of(context).primaryColor,
                        )),
                    context: context,
                    type: AlertType.warning,
                    title: "Delete Alert",
                    desc: "Are you sure you want to delete?",
                    buttons: [
                      DialogButton(
                        child: Text(
                          "NO",
                          style: TextStyle(color: Colors.white, fontSize: 20),
                        ),
                        onPressed: () => Navigator.pop(context),
                        color: Colors.green,
                      ),
                      DialogButton(
                        child: Text(
                          "YES",
                          style: TextStyle(color: Colors.white, fontSize: 20),
                        ),
                        onPressed: () {
                          Provider.of<TaskChangeNotifier>(context,
                                  listen: false)
                              .delete(index);
                          Navigator.pop(context);
                        },
                        color: Colors.red,
                      ),
                    ],
                  ).show();
                },
              );
            },
          );
        });
  }
}
