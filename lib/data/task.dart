import 'package:flutter/cupertino.dart';
import 'package:hive/hive.dart';

part 'task.g.dart';

@HiveType(typeId: 0)
class TaskModel {
  @HiveField(0)
  final String text;
  @HiveField(1)
  final bool isDone;

  TaskModel({this.isDone, this.text});
}

class Task {
  String text;
  bool isDone;
  Task({this.text, this.isDone = false});
  void reDone() {
    isDone = !isDone;
  }
}
