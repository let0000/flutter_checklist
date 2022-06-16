import 'package:checklist/src/app.dart';
import 'package:checklist/src/controller/covid_controller.dart';
import 'package:checklist/src/controller/todo_controller.dart';
import 'package:checklist/src/controller/weather_controller.dart';
import 'package:checklist/src/model/todo.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hive_flutter/adapters.dart';

void main() async {
  await Hive.initFlutter();
  Hive.registerAdapter<Todo>(TodoAdapter());
  await Hive.openBox<Todo>('todos');
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Check List',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      initialBinding: BindingsBuilder(() {
        Get.put(WeatherController());
        Get.put(CovidController());
        Get.put(TodoController());
      }),
      home: const App(),
    );
  }
}

