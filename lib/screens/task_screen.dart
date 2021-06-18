import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:provider/provider.dart';
import 'package:todoey_flutter/Widgets/task_list.dart';
import 'package:todoey_flutter/data/task.dart';
import 'package:todoey_flutter/data/taskchangenotifier.dart';
import 'package:todoey_flutter/data/themedata.dart';
import 'package:todoey_flutter/screens/task_bottom_bar.dart';

class TasksScreen extends StatefulWidget {
  @override
  _TasksScreenState createState() => _TasksScreenState();
}

class _TasksScreenState extends State<TasksScreen> {
  String taskremain() {
    int tasks = Provider.of<TaskChangeNotifier>(context).tasklength;
    if (tasks < 2)
      return "$tasks task remaining";
    else
      return "$tasks tasks remaining";
  }

  bool onOff = false;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      floatingActionButton: FloatingActionButton(
        child: Icon(
          Icons.add,
          size: 30,
        ),
        onPressed: () {
          showModalBottomSheet(
            isScrollControlled: false,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.only(
                topLeft: Radius.circular(30),
                topRight: Radius.circular(30),
              ),
            ),
            context: context,
            builder: (BuildContext context) => SingleChildScrollView(
              child: Container(
                padding: EdgeInsets.only(
                    bottom: MediaQuery.of(context).viewInsets.bottom),
                child: TaskScreen(),
              ),
            ),
          );
        },
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Expanded(
            flex: 3,
            child: Container(
              color: Theme.of(context).backgroundColor,
              padding:
                  EdgeInsets.only(top: 50, left: 30, right: 30, bottom: 30),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Switch.adaptive(
                    activeThumbImage: AssetImage('images/moon.png'),
                    inactiveThumbImage: AssetImage('images/sun.png'),
                    activeTrackColor: Colors.indigo[1000],
                    inactiveTrackColor: Colors.blue[50],
                    value: Provider.of<ThemeProvider>(context).isDarkMode,
                    onChanged: (value) {
                      final provider =
                          Provider.of<ThemeProvider>(context, listen: false);
                      provider.toggleTheme(value);
                    },
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  FittedBox(
                    child: Text(
                      'Todoey',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 50.0,
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  Text(
                    taskremain(),
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 18,
                    ),
                  )
                ],
              ),
            ),
          ),
          Expanded(
            flex: 7,
            child: Container(
              padding: EdgeInsets.only(left: 30, right: 30),
              decoration: BoxDecoration(
                color: Theme.of(context).canvasColor,
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(30),
                  topRight: Radius.circular(30),
                ),
              ),
              child: SingleChildScrollView(
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    SizedBox(
                      height: 7,
                    ),
                    TaskList(
                      hivebox: Hive.box('todolist')
                          .values
                          .where((element) => element.isDone == false)
                          .map<TaskModel>((e) => e)
                          .toList(),
                    ),
                    Divider(
                      indent: 12,
                      endIndent: 12,
                      color: Colors.black,
                    ),
                    TaskListDone(
                      hivebox: Hive.box('todolist')
                          .values
                          .where((element) => element.isDone == true)
                          .map<TaskModel>((e) => e)
                          .toList(),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
