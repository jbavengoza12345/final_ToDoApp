import 'package:flutter/material.dart';


void main() => runApp(ToDoApp());


class ToDoApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'TO DO App',
      theme: ThemeData(
        primarySwatch: Colors.blue,
        scaffoldBackgroundColor: Color.fromARGB(255, 248, 232, 0),
        fontFamily: 'Roboto',
      ),
      home: ToDoHome(),
    );
  }
}


class ToDoHome extends StatefulWidget {
  @override
  _ToDoHomeState createState() => _ToDoHomeState();
}


class _ToDoHomeState extends State<ToDoHome> {
  final List<String> _tasks = [];


  void _addTask(String task) {
    if (task.trim().isNotEmpty) {
      setState(() {
        _tasks.add(task.trim());
      });
    }
  }


  void _deleteTask(int index) {
    setState(() {
      _tasks.removeAt(index);
    });
  }


  void _showAddTaskModal() {
    final controller = TextEditingController();
    showModalBottomSheet(
      context: context,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
      isScrollControlled: true,
      builder: (context) => Padding(
        padding: EdgeInsets.only(
            bottom: MediaQuery.of(context).viewInsets.bottom + 20,
            left: 20,
            right: 20,
            top: 20),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(
              'Add New Task',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            TextField(
              controller: controller,
              autofocus: true,
              decoration: InputDecoration(
                hintText: 'Enter your task here...',
              ),
              onSubmitted: (value) {
                _addTask(value);
                Navigator.pop(context);
              },
            ),
            SizedBox(height: 10),
            ElevatedButton(
              onPressed: () {
                _addTask(controller.text);
                Navigator.pop(context);
              },
              child: Text('Add Task'),
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.deepPurple,
              ),
            ),
          ],
        ),
      ),
    );
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('My TO DOs'),
        elevation: 0,
        backgroundColor: Colors.deepPurple,
      ),
      body: _tasks.isEmpty
          ? Center(
              child: Text(
                'No tasks yet. Tap + to add one!',
                style: TextStyle(fontSize: 16, color: Colors.grey),
              ),
            )
          : ListView.builder(
              padding: EdgeInsets.all(10),
              itemCount: _tasks.length,
              itemBuilder: (context, index) => Card(
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12)),
                elevation: 4,
                child: ListTile(
                  leading: Icon(Icons.check_circle_outline,
                      color: Colors.deepPurple),
                  title: Text(
                    _tasks[index],
                    style: TextStyle(fontSize: 16),
                  ),
                  trailing: IconButton(
                    icon: Icon(Icons.delete, color: Colors.redAccent),
                    onPressed: () => _deleteTask(index),
                  ),
                ),
              ),
            ),
      floatingActionButton: FloatingActionButton(
        onPressed: _showAddTaskModal,
        backgroundColor: Colors.deepPurple,
        child: Icon(Icons.add),
      ),
    );
  }
}


