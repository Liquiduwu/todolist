import 'package:flutter/material.dart';

class AddTaskDialog extends StatelessWidget {
  final Function(String) onAdd;

  const AddTaskDialog({super.key, required this.onAdd});

  @override
  Widget build(BuildContext context) {
    final controller = TextEditingController();

    return AlertDialog(
      title: const Text('Add New Task'),
      content: TextField(
        controller: controller,
        decoration: const InputDecoration(
          labelText: 'Task Title',
        ),
        autofocus: true,
      ),
      actions: [
        TextButton(
          onPressed: () => Navigator.pop(context),
          child: const Text('Cancel'),
        ),
        TextButton(
          onPressed: () {
            if (controller.text.isNotEmpty) {
              onAdd(controller.text);
              Navigator.pop(context);
            }
          },
          child: const Text('Add'),
        ),
      ],
    );
  }
} 