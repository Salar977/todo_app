import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:provider/provider.dart';
import 'package:todo_app/data/database.dart';
import 'package:todo_app/theme/theme_provider.dart';
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
      backgroundColor: Theme.of(context).colorScheme.surface,
      appBar: AppBar(
        title: Text(
          "TODO APP",
        ),
        centerTitle: true,
        backgroundColor: Theme.of(context).colorScheme.secondary,
        actions: [
          Padding(
            padding: const EdgeInsets.only(right: 15),
            child: IconButton(
              onPressed: Provider.of<ThemeProvider>(context, listen: false).toggleTheme,
              icon: Icon(
                Icons.dark_mode,
                size: 30,
              )
            ),
          )
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: createNewTask,
        backgroundColor: Theme.of(context).colorScheme.primary,
        child: Icon(Icons.add, color: Colors.white,),
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