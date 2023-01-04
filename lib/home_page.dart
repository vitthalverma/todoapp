import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:noshbae/data/database.dart';
import 'package:noshbae/utils/dialog_box.dart';

import 'todo_tile.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
// refrence hive box
  final _myBox = Hive.box('mybox');
  ToDoDatabase db = ToDoDatabase();

  @override
  void initState() {
    // if this is the 1st time user opening the app create default data
    if (_myBox.get('TODOLIST') == null) {
      db.createInitialData();
    } else {
      // there already exists data
      db.loadData();
    }
    super.initState();
  }

// new task controller
  final _controller = TextEditingController();

// checkbox was tapped
  void checkBoxChanged(bool? value, int index) {
    setState(() {
      db.toDoList[index][1] = !db.toDoList[index][1];
    });
    db.updateDatabase();
  }

  // create a new task
  void createNewTask() {
    showDialog(
      context: context,
      builder: ((context) {
        return DialogBox(
          controller: _controller,
          onSaved: saveNewTask,
          onCancel: (() {
            _controller.clear();
            Navigator.pop(context);
          }),
        );
      }),
    );
  }

  // save new task
  void saveNewTask() {
    setState(() {
      db.toDoList.add([_controller.text, false]);
      _controller.clear();
    });
    Navigator.pop(context);
    db.updateDatabase();
  }

  // delete a task
  void deleteTask(int index) {
    setState(() {
      db.toDoList.removeAt(index);
    });
    db.updateDatabase();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.yellow.shade400,
      appBar: AppBar(
        elevation: 1,
        backgroundColor: Colors.yellow.shade600,
        title: const Center(
          child: Text(
            'TO DO',
            style: TextStyle(
              color: Colors.black,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: Colors.yellow.shade700,
        onPressed: createNewTask,
        child: const Icon(Icons.add),
      ),
      body: db.toDoList.isEmpty
          ? Center(
              child: Text('Add Your Tasks!',
                  style: GoogleFonts.bebasNeue(fontSize: 40)))
          : ListView.builder(
              itemCount: db.toDoList.length,
              itemBuilder: ((context, index) {
                return ToDoTile(
                  taskName: db.toDoList[index][0],
                  taskCompleted: db.toDoList[index][1],
                  onChanged: ((value) {
                    checkBoxChanged(value, index);
                  }),
                  deleteFunction: ((context) => deleteTask(index)),
                );
              }),
            ),
    );
  }
}
