import 'package:flutter/material.dart';
import '../models/task.dart';
import '../widgets/task_tile.dart';
import '../widgets/add_task_dialog.dart';

class TodoListScreen extends StatefulWidget {
  const TodoListScreen({super.key});

  @override
  State<TodoListScreen> createState() => _TodoListScreenState();
}

class _TodoListScreenState extends State<TodoListScreen> {
  final List<Task> _tasks = [];

  void _addTask(String title) {
    setState(() {
      _tasks.add(Task(
        id: DateTime.now().toString(),
        title: title,
      ));
    });
  }

  void _deleteTask(String id) {
    setState(() {
      _tasks.removeWhere((task) => task.id == id);
    });
  }

  void _toggleTask(String id) {
    setState(() {
      final task = _tasks.firstWhere((task) => task.id == id);
      task.isCompleted = !task.isCompleted;
    });
  }

  void _editTask(String id, String newTitle) {
    setState(() {
      final task = _tasks.firstWhere((task) => task.id == id);
      task.title = newTitle;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('My Todo List'),
        centerTitle: true,
      ),
      body: _tasks.isEmpty
          ? const Center(
              child: Text(
                'No tasks yet!\nTap + to add a new task',
                textAlign: TextAlign.center,
                style: TextStyle(fontSize: 18),
              ),
            )
          : ListView.builder(
              padding: const EdgeInsets.all(16),
              itemCount: _tasks.length,
              itemBuilder: (context, index) {
                final task = _tasks[index];
                return TaskTile(
                  task: task,
                  onToggle: _toggleTask,
                  onDelete: _deleteTask,
                  onEdit: _editTask,
                );
              },
            ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          showDialog(
            context: context,
            builder: (context) => AddTaskDialog(onAdd: _addTask),
          );
        },
        child: const Icon(Icons.add),
      ),
    );
  }
} 