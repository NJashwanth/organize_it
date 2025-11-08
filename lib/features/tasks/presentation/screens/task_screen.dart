import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:organize_it/features/tasks/domain/entities/task.dart';
import '../providers/task_provider.dart';
import '../widgets/task_edit_dialog.dart';
import '../widgets/task_list_tile.dart';

class TaskScreen extends ConsumerStatefulWidget {
  const TaskScreen({super.key});

  @override
  ConsumerState<TaskScreen> createState() => _TaskScreenState();
}

class _TaskScreenState extends ConsumerState<TaskScreen> {
  @override
  void initState() {
    super.initState();
    Future.microtask(() => ref.read(tasksProvider.notifier).loadTasks());
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final AsyncValue<List<TaskEntity>> tasksValue = ref.watch(tasksProvider);
    final notifier = ref.read(tasksProvider.notifier);

    return Scaffold(
      appBar: AppBar(title: const Text('Tasks')),
      body: tasksValue.when(
        data: (tasks) {
          if (tasks.isEmpty) {
            return const Center(child: Text('No tasks found!'));
          }

          // Split tasks into active and completed
          final activeTasks = tasks.where((t) => !t.isCompleted).toList()
            ..sort((a, b) => b.priority.index.compareTo(a.priority.index));
          final completedTasks = tasks.where((t) => t.isCompleted).toList()
            ..sort((a, b) => b.priority.index.compareTo(a.priority.index));

          return Padding(
            padding: const EdgeInsets.all(16.0),
            child: ListView(
              children: [
                // Active Tasks Section
                if (activeTasks.isNotEmpty) ...[
                  Text('Active Tasks',
                      style: theme.textTheme.titleLarge?.copyWith(
                        fontWeight: FontWeight.bold,
                        color: theme.primaryColor,
                      )),
                  const SizedBox(height: 8),
                  ...activeTasks.map((task) => TaskListTile(
                        task: task,
                        onToggleComplete: (value) {
                          notifier.updateTask(task, isCompleted: value);
                        },
                        onEdit: () => _showEditDialog(task),
                        onDelete: () => notifier.deleteTask(task.id),
                      )),
                ],

                // Completed Tasks Section
                if (completedTasks.isNotEmpty) ...[
                  const SizedBox(height: 24),
                  ExpansionTile(
                    title: Text(
                      'Completed Tasks (${completedTasks.length})',
                      style: theme.textTheme.titleLarge?.copyWith(
                        fontWeight: FontWeight.w500,
                        color: Colors.grey[600],
                      ),
                    ),
                    children: completedTasks
                        .map((task) => TaskListTile(
                              task: task,
                              onToggleComplete: (value) {
                                notifier.updateTask(task, isCompleted: value);
                              },
                              onEdit: () => _showEditDialog(task),
                              onDelete: () => notifier.deleteTask(task.id),
                            ))
                        .toList(),
                  ),
                ],
              ],
            ),
          );
        },
        loading: () => const Center(child: CircularProgressIndicator()),
        error: (error, stack) => Center(
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Icon(Icons.error_outline,
                    size: 64, color: theme.colorScheme.error),
                const SizedBox(height: 12),
                Text(
                  'Something went wrong',
                  style: theme.textTheme.titleMedium?.copyWith(
                    color: theme.colorScheme.error,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 8),
                Text(error.toString()),
                const SizedBox(height: 12),
                ElevatedButton(
                  onPressed: () => notifier.loadTasks(),
                  child: const Text('Retry'),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Future<void> _showEditDialog(TaskEntity task) async {
    final provider = ref.read(tasksProvider.notifier);

    final result = await showDialog<TaskEditResult>(
      context: context,
      builder: (context) => TaskEditDialog(task: task),
    );

    if (result != null) {
      // apply changes using provider
      provider.updateTask(
        task,
        title: result.title,
        description: result.description,
        priority: result.priority,
      );
    }
  }
}
