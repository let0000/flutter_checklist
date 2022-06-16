import 'package:checklist/src/components/covid_view.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'components/todo_tile.dart';
import 'components/weather_view.dart';
import 'controller/todo_controller.dart';
import 'model/todo.dart';
import 'package:intl/intl.dart';

class App extends StatefulWidget {
  const App({Key? key}) : super(key: key);

  @override
  State<App> createState() => _AppState();
}

class _AppState extends State<App> {
  final todoController = Get.find<TodoController>();

  Future<void> _showMyDialog() async {
    return showDialog<void>(
      context: context,
      barrierDismissible: false, // user must tap button!
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('일정 등록'),
          content: TextField(
            autofocus: true,
            onSubmitted: (String text) {
              setState(() {
                todoController.addTodo(Todo(title: text));
              });
              Get.back();
            },
            textInputAction: TextInputAction.send,
          ),
        );
      },
    );
  }

  String getSystemTime() {
    var now = DateTime.now();
    return DateFormat('yyyy / MM / dd').format(now);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.transparent,
          elevation: 0.0,
          centerTitle: true,
          title: Text(getSystemTime(),
          style: const TextStyle(
            color: Colors.black,
            fontSize: 20
          ),),
        ),
        floatingActionButton: Stack(
          children: [
            Align(
              alignment: Alignment(
                  Alignment.bottomRight.x - 0.4, Alignment.bottomRight.y),
              child: FloatingActionButton(
                onPressed: () {
                  todoController.allchangeStatus();
                  setState(() {});
                },
                tooltip: '초기화',
                child: const Icon(Icons.refresh),
              ),
            ),
            Align(
              alignment: Alignment.bottomRight,
              child: FloatingActionButton(
                onPressed: () {
                  _showMyDialog();
                },
                tooltip: '일정 추가',
                child: const Icon(Icons.add),
              ),
            ),
          ],
        ),
        body:
            Column(
              children: [
                Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: const [
                        CovidView(), // 날씨 뷰어
                        WeatherView(), // 코로나 뷰어
                      ],
                    ),
                Expanded(
                    child: ReorderableListView(
                      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
                      proxyDecorator: (Widget child, int index, Animation<double> animation) {
                        return TodoTile(
                            todo: todoController.todos[index],
                            onDeleted: () {
                              todoController.deleteTodo(todoController.todos[index]);
                              setState(() {});
                            });
                      },
                      children: <Widget>[
                        for (int index = 0; index < todoController.todos.length; index += 1)
                          Padding(
                            key: Key('$index'),
                            padding: const EdgeInsets.all(8.0),
                            child: TodoTile(
                              todo: todoController.todos[index],
                              onDeleted: () {
                                todoController.deleteTodo(todoController.todos[index]);
                                setState(() {});
                              },
                            ),
                          )
                      ],
                      onReorder: (int oldIndex, int newIndex) async {
                        if (oldIndex < newIndex) {
                          newIndex -= 1;
                          await todoController.reorder(oldIndex, newIndex);
                          setState(() {});
                        }
                      },
                    ))
              ],
            ),
        );
  }
}
