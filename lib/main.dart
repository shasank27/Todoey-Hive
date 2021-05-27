import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'screens/task_screen.dart';
import 'package:todoey_flutter/data/taskshouter.dart';
import 'package:todoey_flutter/data/themedata.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) => TaskShouter(),
      child: MaterialApp(
        theme: MyTheme.light,
        darkTheme: MyTheme.dark,
        themeMode: ThemeMode.dark,
        debugShowCheckedModeBanner: false,
        home: TasksScreen(),
      ),
    );
  }
}
