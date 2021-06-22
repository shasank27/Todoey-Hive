import 'package:hive/hive.dart';

part 'task.g.dart';

@HiveType(typeId: 0)
class TaskModel {
  @HiveField(3)
  final String text;
  @HiveField(4)
  final bool isDone;
  @HiveField(5)
  final uuid;

  TaskModel({this.isDone, this.text, this.uuid});
}
