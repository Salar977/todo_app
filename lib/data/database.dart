import 'package:hive_flutter/hive_flutter.dart';

class ToDoDatabase {

  List todoList = [];

  // reference our box
  final _myBox = Hive.box('mybox');

  // run this method the first time running the app
  void createinitialData() {
    todoList = [
      ["Make this tutorial", false],
      ["Make Food", false]
    ];
  }

  // load the data from the database
  void loadData() {
    todoList = _myBox.get("TODOLIST");
  }

  // update the database
  void updateDatabase() {
    _myBox.put("TODOLIST", todoList);
  }
}