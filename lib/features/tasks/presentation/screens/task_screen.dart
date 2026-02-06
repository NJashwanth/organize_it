import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:organize_it/features/tasks/domain/entities/task.dart';
import 'package:organize_it/features/tasks/presentation/providers/task_provider.dart';
import 'package:organize_it/features/tasks/presentation/widgets/task_edit_dialog.dart';
import 'package:organize_it/features/tasks/presentation/widgets/task_list_tile.dart';
import 'package:organize_it/core/widgets/organize_it_loading.dart';
import 'package:organize_it/core/widgets/organize_it_error.dart';
import 'package:organize_it/features/tasks/presentation/screens/task_create_screen.dart';

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
      appBar: AppBar(
        title: Text(
          'Tasks',
          style: theme.textTheme.titleLarge?.copyWith(
            color: theme.colorScheme.onSurface,
          ),
        ),
        backgroundColor: theme.colorScheme.surface,
        elevation: 0,
      ),
      backgroundColor: theme.colorScheme.surface,
      body: tasksValue.when(
        data: (tasks) {
          if (tasks.isEmpty) {
            return Center(
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Icon(
                    Icons.task_alt,
                    size: 64,
                    color: theme.colorScheme.onSurfaceVariant,
                  ),
                  const SizedBox(height: 16),
                  Text(
                    'No tasks found!',
                    style: theme.textTheme.titleMedium?.copyWith(
                      color: theme.colorScheme.onSurfaceVariant,
                    ),
                  ),
                ],
              ),
            );
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
                  Padding(
                    padding: const EdgeInsets.only(left: 8.0),
                    child: Row(
                      children: [
                        Icon(
                          Icons.radio_button_unchecked,
                          size: 20,
                          color: theme.colorScheme.primary,
                        ),
                        const SizedBox(width: 8),
                        Text(
                          'Active Tasks',
                          style: theme.textTheme.titleLarge?.copyWith(
                            fontWeight: FontWeight.bold,
                            color: theme.colorScheme.primary,
                          ),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(height: 16),
                  ...activeTasks.map(
                    (task) => Padding(
                      padding: const EdgeInsets.only(bottom: 8.0),
                      child: TaskListTile(
                        task: task,
                        onToggleComplete: (value) {
                          notifier.updateTask(task, isCompleted: value);
                        },
                        onEdit: () => _showEditDialog(task),
                        onDelete: () => notifier.deleteTask(task.id),
                      ),
                    ),
                  ),
                ],

                // Completed Tasks Section
                if (completedTasks.isNotEmpty) ...[
                  const SizedBox(height: 24),
                  Theme(
                    data: Theme.of(
                      context,
                    ).copyWith(dividerColor: Colors.transparent),
                    child: ExpansionTile(
                      title: Row(
                        children: [
                          Icon(
                            Icons.check_circle_outline,
                            size: 20,
                            color: theme.colorScheme.onSurfaceVariant,
                          ),
                          const SizedBox(width: 8),
                          Text(
                            'Completed Tasks (${completedTasks.length})',
                            style: theme.textTheme.titleMedium?.copyWith(
                              fontWeight: FontWeight.w500,
                              color: theme.colorScheme.onSurfaceVariant,
                            ),
                          ),
                        ],
                      ),
                      iconColor: theme.colorScheme.onSurfaceVariant,
                      collapsedIconColor: theme.colorScheme.onSurfaceVariant,
                      children: completedTasks
                          .map(
                            (task) => Padding(
                              padding: const EdgeInsets.only(
                                left: 16.0,
                                right: 16.0,
                                bottom: 8.0,
                              ),
                              child: TaskListTile(
                                task: task,
                                onToggleComplete: (value) {
                                  notifier.updateTask(task, isCompleted: value);
                                },
                                onEdit: () => _showEditDialog(task),
                                onDelete: () => notifier.deleteTask(task.id),
                              ),
                            ),
                          )
                          .toList(),
                    ),
                  ),
                ],
              ],
            ),
          );
        },
        loading: () => const Center(child: OrganizeItLoading()),
        error: (error, stack) => OrganizeItError(
          title: 'We couldn\'t load your tasks',
          message:
              'Please check your connection and try again. Your tasks are safe.',
          details: 'Details: ${error.toString()}',
          actionLabel: 'Try again',
          onAction: () => notifier.loadTasks(),
        ),
      ),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () async {
          // navigate to full screen create page
          await Navigator.of(
            context,
          ).push(MaterialPageRoute(builder: (_) => const TaskCreateScreen()));
        },
        icon: const Icon(Icons.add),
        label: const Text('Add Task'),
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
