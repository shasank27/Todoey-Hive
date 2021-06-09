import 'dart:io';
import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:path_provider/path_provider.dart';
import 'package:provider/provider.dart';
import 'package:todoey_flutter/data/task.dart';
import 'screens/task_screen.dart';
import 'package:todoey_flutter/data/themedata.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  Directory directory = await getApplicationDocumentsDirectory();
  Hive.registerAdapter<TaskModel>(TaskModelAdapter());
  Hive.init(directory.path);
  await Hive.openBox('todolist');
  runApp(MyApp());
}

class MyApp extends StatefulWidget {
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(
          create: (context) => ThemeProvider(),
          builder: (context, _) {
            final themeProvider = Provider.of<ThemeProvider>(context);
            return MaterialApp(
              theme: MyTheme.light,
              darkTheme: MyTheme.dark,
              themeMode: themeProvider.themeMode,
              debugShowCheckedModeBanner: false,
              home: FutureBuilder(
                future: Hive.openBox('todolist'),
                builder: (BuildContext context, AsyncSnapshot snapshot) {
                  if (snapshot.connectionState == ConnectionState.done) {
                    if (snapshot.hasError)
                      return Text(snapshot.error.toString());
                    else
                      return TasksScreen();
                  } else
                    return Scaffold();
                },
              ),
            );
          },
        ),
      ],
    );
  }

  @override
  void dispose() {
    Hive.box('todolist').close();
    super.dispose();
  }
}
