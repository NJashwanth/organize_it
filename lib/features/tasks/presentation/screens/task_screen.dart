import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:organize_it/features/tasks/domain/entities/task.dart';
import '../providers/task_provider.dart';

class TaskScreen extends ConsumerWidget {
  const TaskScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final List<TaskEntity> tasks = ref.watch(taskProvider);

    return Scaffold(
      appBar: AppBar(title: const Text('Tasks')),
      body: tasks.isEmpty
          ? const Center(child: Text('No tasks found!'))
          : ListView.builder(
              itemCount: tasks.length,
              itemBuilder: (BuildContext context, int index) {
                final TaskEntity task = tasks[index];
                return ListTile(
                  title: Text(task.title),
                  subtitle: Text(task.description),
                  trailing: Checkbox(
                    value: task.isCompleted,
                    onChanged: (bool? value) {
                      ref
                          .read(taskProvider.notifier)
                          .updateTask(task.id, <String,dynamic >{'isCompleted': value});
                    },
                  ),
                  onLongPress: () {
                    ref.read(taskProvider.notifier).deleteTask(task.id);
                  },
                );
              },
            ),
    );
  }
}
