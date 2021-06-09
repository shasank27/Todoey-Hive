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
