import 'package:hive_flutter/hive_flutter.dart';

class ToDoDatabase {
  List toDoList = [];

  // reference hive box
  final _myBox = Hive.box('mybox');

  // run this methos if this is the first time user opening the app
  void createInitialData() {
    toDoList = [
      ['Make Tutorial', false],
      ['Do ExerSice', false],
    ];
  }

  // load the data from database
  void loadData() {
    toDoList = _myBox.get('TODOLIST');
  }

  // update the database
  void updateDatabase() {
    _myBox.put('TODOLIST', toDoList);
  }
}
