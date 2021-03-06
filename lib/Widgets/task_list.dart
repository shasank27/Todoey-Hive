import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:hive/hive.dart';
import 'package:rflutter_alert/rflutter_alert.dart';
import 'package:provider/provider.dart';
import 'package:todoey_flutter/data/task.dart';
import 'package:todoey_flutter/data/taskchangenotifier.dart';
import 'package:todoey_flutter/screens/task_screen.dart';
import 'task_tile.dart';

class TaskListDone extends StatefulWidget {
  final List<TaskModel> hivebox;
  TaskListDone({@required this.hivebox});
  @override
  _TaskListDoneState createState() => _TaskListDoneState();
}

class _TaskListDoneState extends State<TaskListDone> {
  TaskChangeNotifier taskChangeNotifier;
  TasksScreen task;
  @override
  Widget build(BuildContext context) {
    return BuildValueListenableBuilder(
      hivebox: widget.hivebox,
    );
  }
}

class TaskList extends StatefulWidget {
  final List<TaskModel> hivebox;
  TaskList({@required this.hivebox});
  @override
  _TaskListState createState() => _TaskListState();
}

class _TaskListState extends State<TaskList> {
  TaskChangeNotifier taskChangeNotifier;
  TasksScreen task;
  @override
  Widget build(BuildContext context) {
    return BuildValueListenableBuilder(
      hivebox: widget.hivebox,
    );
  }
}

class BuildValueListenableBuilder extends StatefulWidget {
  final List<TaskModel> hivebox;
  BuildValueListenableBuilder({@required this.hivebox});

  @override
  _BuildValueListenableBuilderState createState() =>
      _BuildValueListenableBuilderState();
}

class _BuildValueListenableBuilderState
    extends State<BuildValueListenableBuilder> {
  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder(
        valueListenable: Hive.box('todolist').listenable(),
        builder: (context, value, _) {
          return ListView.builder(
            physics: NeverScrollableScrollPhysics(),
            shrinkWrap: true,
            padding: EdgeInsets.only(top: 10),
            itemCount: widget.hivebox.length,
            itemBuilder: (context, index) {
              return TaskTile(
                  isChecked: widget.hivebox[index].isDone,
                  taskTitle: widget.hivebox[index].text,
                  toggleCheckBox: (value) {
                    Provider.of<TaskChangeNotifier>(context, listen: false)
                        .put(widget.hivebox[index].uuid);
                  },
                  deleteonLongPress: () {
                    Alert(
                      style: AlertStyle(
                        alertPadding: EdgeInsets.all(10),
                        alertBorder: RoundedRectangleBorder(
                          side: BorderSide.none,
                          borderRadius: BorderRadius.all(
                            Radius.circular(30),
                          ),
                        ),
                        backgroundColor: Theme.of(context).canvasColor,
                        titleStyle: TextStyle(
                          color: Theme.of(context).primaryColor,
                        ),
                        descStyle: TextStyle(
                          color: Theme.of(context).primaryColor,
                        ),
                      ),
                      context: context,
                      type: AlertType.warning,
                      title: "Delete Alert",
                      desc: "Are you sure you want to delete?",
                      buttons: [
                        DialogButton(
                          radius: BorderRadius.circular(20),
                          child: Text(
                            "NO",
                            style: TextStyle(color: Colors.white, fontSize: 20),
                          ),
                          onPressed: () => Navigator.pop(context),
                          color: Colors.blueGrey,
                        ),
                        DialogButton(
                          radius: BorderRadius.circular(20),
                          child: Text(
                            "YES",
                            style: TextStyle(color: Colors.white, fontSize: 20),
                          ),
                          onPressed: () {
                            Provider.of<TaskChangeNotifier>(context,
                            listen: false)
                            .delete(widget.hivebox[index].uuid);
                            Navigator.pop(context);
                          },
                          color: Color(0xffFF616D),
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
