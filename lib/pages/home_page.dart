import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:todo_app/data/database.dart';
import 'package:todo_app/util/dialog_box.dart';
import 'package:todo_app/util/todo_tile.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {

  // db connection
  ToDoDatabase db = new ToDoDatabase();

  // reference the hive box
  final _myBox = Hive.box('mybox');

  @override
  void initState() {

    // if this is the first time running the app
    if (_myBox.get("TODOLIST") == null) {
      db.createinitialData();
    } else {
      // there already exists data
      db.loadData();
    }

    super.initState();
  }

  // Text controller
  final _controller = TextEditingController();

  // checkbox was tapped
  void checkboxChanged(bool? value, int index) {
    setState(() {
      db.todoList[index][1] = !db.todoList[index][1]; 
    });
    db.updateDatabase();
  }

  // onSave
  void saveNewTask() {
    setState(() {
      db.todoList.add([_controller.text, false]);
      _controller.clear();
    });
    Navigator.of(context).pop();
    db.updateDatabase();
  }

  // Create new task
  void createNewTask() {
    showDialog(context: context, builder: (context) {
      return DialogBox(
        controller: _controller,
        onSave: saveNewTask,
        onCancel: Navigator.of(context).pop,
      );
    },);
  }

  // delete a task
  void deleteTask(int index) {
    setState(() {
      db.todoList.removeAt(index);
    });
    db.updateDatabase();
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.yellow[200],
      appBar: AppBar(
        title: Center(child: Text("TODO APP")),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: createNewTask,
        child: Icon(Icons.add),
      ),
      body: ListView.builder(
        itemCount: db.todoList.length,
        itemBuilder: (context, index) {
          return ToDoTile(
            taskName: db.todoList[index][0],
            taskCompleted: db.todoList[index][1],
            onChanged: (value) => checkboxChanged(value, index),
            onSlide: (context) => deleteTask(index),

          );
        },
      ),
    );
  }
}