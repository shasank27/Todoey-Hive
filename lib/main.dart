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
  Hive.init(directory.path);
  await Hive.openBox('todolist');
  Hive.registerAdapter(TaskModelAdapter());
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
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
              home: TasksScreen(),
            );
          },
        ),
      ],
    );
  }
}
