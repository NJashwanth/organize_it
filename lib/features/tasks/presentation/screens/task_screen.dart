import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:organize_it/features/tasks/domain/entities/task.dart';
import '../providers/task_provider.dart';

class TaskScreen extends ConsumerStatefulWidget {
  const TaskScreen({super.key});

  @override
  ConsumerState<TaskScreen> createState() => _TaskScreenState();
}

class _TaskScreenState extends ConsumerState<TaskScreen> {
  @override
  void initState() {
    super.initState();
    Future.microtask(() => ref.read(taskProvider.notifier).loadTasks());
  }

  @override
  Widget build(BuildContext context) {
    final List<TaskEntity> tasks = ref.watch(taskProvider);
    final notifier = ref.read(taskProvider.notifier);

    return Scaffold(
      appBar: AppBar(title: const Text('Tasks')),
      body: tasks.isEmpty
          ? const Center(child: Text('No tasks found!'))
          : Padding(
              padding: const EdgeInsets.all(16.0),
              child: ListView.builder(
                itemCount: tasks.length,
                itemBuilder: (BuildContext context, int index) {
                  final TaskEntity task = tasks[index];

                  return Card(
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        verticalDirection: VerticalDirection.down,
                        spacing: 2,
                        children: [
                          Column(
                            mainAxisAlignment: MainAxisAlignment.start,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(task.title),
                              Text(task.description),
                            ],
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            spacing: 3,
                            children: [
                              Checkbox(
                                value: task.isCompleted,
                                onChanged: (bool? value) {
                                  notifier.updateTask(
                                    task,
                                    isCompleted: value,
                                  );
                                },
                              ),
                              IconButton(
                                icon: const Icon(Icons.edit),
                                onPressed: () {
                                  // Handle edit action
                                  _showEditDialog(task);
                                },
                              ),
                              IconButton(
                                icon: const Icon(Icons.delete),
                                onPressed: () {
                                  // Handle delete action
                                  notifier.deleteTask(task.id);
                                },
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                  );
                },
              ),
            ),
    );
  }

  Future<void> _showEditDialog(TaskEntity task) async {
    final TextEditingController titleController =
        TextEditingController(text: task.title);
    final TextEditingController descriptionController =
        TextEditingController(text: task.description);

    TaskPriority? selectedPriority = task.priority;

    final provider = ref.read(taskProvider.notifier);

    await showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Edit Task'),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: <Widget>[
              TextField(
                controller: titleController,
                decoration: const InputDecoration(labelText: 'Title'),
              ),
              TextField(
                controller: descriptionController,
                decoration: const InputDecoration(labelText: 'Description'),
              ),
              DropdownButton<TaskPriority>(
                value: selectedPriority,
                onChanged: (TaskPriority? newValue) {
                  setState(() {
                    selectedPriority = newValue;
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
              onPressed: () {
                // Close the dialog
                Navigator.pop(context);
              },
              child: const Text('Cancel'),
            ),
            TextButton(
              onPressed: () {
                // Update the task with the new title, description, and priority
                provider.updateTask(
                  task,
                  title: titleController.text,
                  description: descriptionController.text,
                  priority: selectedPriority,
                );

                // Close the dialog
                Navigator.pop(context);
              },
              child: const Text('Save'),
            ),
          ],
        );
      },
    );
  }
}
