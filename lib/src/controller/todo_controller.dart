import 'package:get/get.dart';
import 'package:hive/hive.dart';

import '../model/todo.dart';

class TodoController extends GetxController {
  late List<Todo> _todos;
  late Box<Todo> todoBox;

  List<Todo> get todos => _todos;

  TodoController() {
    todoBox = Hive.box<Todo>('todos');
    _todos = [];
    for(int i = 0; i < todoBox.values.length; i++) {
      _todos.add(todoBox.getAt(i)!);
    }
  }

  Future reorder(int oldIndex, int newIndex) async {
    List<Todo> newTodos = [];
    newTodos.addAll(todoBox.values);

    final Todo item = newTodos.removeAt(oldIndex);
    newTodos.insert(newIndex, item);
    await todoBox.clear();
    await todoBox.addAll(newTodos);
    _todos.clear();
    _todos.addAll(newTodos);
  }

  addTodo(Todo todo) {
    _todos.add(todo);
    todoBox.add(todo);
    update();
  }

  deleteTodo(Todo todo) {
    int index = _todos.indexOf(todo);
    todoBox.deleteAt(index);
    _todos.removeWhere((element) => element.id == todo.id);
    update();
  }

  changeStatus(Todo todo) {
    int index = _todos.indexOf(todo);
    _todos[index].finished = !_todos[index].finished;
    todoBox.putAt(index, _todos[index]);
    update();
  }

  allchangeStatus() {
    for(int i = 0; i < _todos.length; i++) {
      _todos[i].finished = false;
      todoBox.putAt(i, _todos[i]);
    }
    update();
  }
}