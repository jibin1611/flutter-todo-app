// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables, unused_field

import 'package:flutter/material.dart';
import 'package:flutter_application_2/data/database.dart';
import 'package:flutter_application_2/util/todo_tile.dart';
import 'package:hive_flutter/hive_flutter.dart';
import '../util/dailogbox.dart';

class Todo extends StatefulWidget {
  const Todo({super.key});

  @override
  State<Todo> createState() => _TodoState();
}

class _TodoState extends State<Todo> {
  final _myBox = Hive.box('mybox');
  ToDoDataBAse db = ToDoDataBAse();

  final _controller = TextEditingController();

  void initStart() {
    if (_myBox.get("TODOLIST") == null) {
      db.createDatabase();
    } else {
      db.loadData();
    }

    super.initState();
  }

  void checkboxChanged(bool? value, int index) {
    setState(() {
      db.todolist[index][1] = !db.todolist[index][1];
      db.updateDatabse();
    });
  }

  void saveTask() {
    setState(() {
      db.todolist.add([_controller.text, false]);
      _controller.clear();
      db.updateDatabse();
    });
    Navigator.of(context).pop();
  }

  void createTask() {
    showDialog(
      context: context,
      builder: (context) {
        return DialogBox(
          controller: _controller,
          onCancel: () => Navigator.of(context).pop(),
          onSave: saveTask,
        );
      },
    );
  }

  void deleteTask(int index) {
    setState(() {
      db.todolist.removeAt(index);
      db.updateDatabse();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.yellow[200],
      appBar: AppBar(
        backgroundColor: Colors.yellow,
        title: Center(child: Text("TODO")),
        elevation: 0,
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: createTask,
        backgroundColor: Colors.yellow,
        elevation: 9,
        child: Icon(Icons.add),
      ),
      body: ListView.builder(
        itemCount: db.todolist.length,
        itemBuilder: (context, index) {
          return TodoTile(
            taskName: db.todolist[index][0],
            taskComplted: db.todolist[index][1],
            onChanged: (value) => checkboxChanged(value, index),
            deleteFunction: (context) => deleteTask(index),
          );
        },
      ),
    );
  }
}
