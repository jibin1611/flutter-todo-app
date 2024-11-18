// ignore_for_file: unused_field

import 'package:hive_flutter/hive_flutter.dart';

class ToDoDataBAse {
  List todolist = [];
  final _myBox = Hive.box('mybox');

  void createDatabase() {
    todolist = [
      ["Make tutorial", false],
      ["Do Excercise", false]
    ];
  }

  void loadData() {
    todolist = _myBox.get("TODOLIST");
  }

  void updateDatabse() {
    _myBox.put("TODOLIST", todolist);
  }
}
