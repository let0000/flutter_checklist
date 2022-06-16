import 'package:hive/hive.dart';
import 'package:uuid/uuid.dart';
part 'todo.g.dart';

@HiveType(typeId: 0)
class Todo extends HiveObject {
  @HiveField(0)
  String id;
  @HiveField(1)
  String title;
  @HiveField(2)
  bool finished;

  Todo({required this.title})
      : this.id = Uuid().v1(),
        this.finished = false;
}