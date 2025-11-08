import 'package:flutter/material.dart';
import '../../domain/entities/task.dart';

class TaskEditResult {
  final String title;
  final String description;
  final TaskPriority? priority;

  TaskEditResult(
      {required this.title, required this.description, this.priority});
}

class TaskEditDialog extends StatefulWidget {
  final TaskEntity task;

  const TaskEditDialog({super.key, required this.task});

  @override
  State<TaskEditDialog> createState() => _TaskEditDialogState();
}

class _TaskEditDialogState extends State<TaskEditDialog> {
  late final TextEditingController _titleController;
  late final TextEditingController _descriptionController;
  TaskPriority? _selectedPriority;

  @override
  void initState() {
    super.initState();
    _titleController = TextEditingController(text: widget.task.title);
    _descriptionController =
        TextEditingController(text: widget.task.description);
    _selectedPriority = widget.task.priority;
  }

  @override
  void dispose() {
    _titleController.dispose();
    _descriptionController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: const Text('Edit Task'),
      content: Column(
        mainAxisSize: MainAxisSize.min,
        children: <Widget>[
          TextField(
            controller: _titleController,
            decoration: const InputDecoration(labelText: 'Title'),
          ),
          TextField(
            controller: _descriptionController,
            decoration: const InputDecoration(labelText: 'Description'),
          ),
          const SizedBox(height: 8),
          DropdownButton<TaskPriority>(
            value: _selectedPriority,
            onChanged: (TaskPriority? newValue) {
              setState(() {
                _selectedPriority = newValue;
              });
            },
            items: TaskPriority.values
                .map<DropdownMenuItem<TaskPriority>>((TaskPriority value) {
              return DropdownMenuItem<TaskPriority>(
                value: value,
                child: Text(value.toString().split('.').last.toUpperCase()),
              );
            }).toList(),
          ),
        ],
      ),
      actions: <Widget>[
        TextButton(
          onPressed: () => Navigator.pop(context),
          child: const Text('Cancel'),
        ),
        TextButton(
          onPressed: () {
            final result = TaskEditResult(
              title: _titleController.text,
              description: _descriptionController.text,
              priority: _selectedPriority,
            );
            Navigator.pop(context, result);
          },
          child: const Text('Save'),
        ),
      ],
    );
  }
}
