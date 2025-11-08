import 'package:flutter/material.dart';
import '../../domain/entities/task.dart';

typedef TaskToggleCallback = void Function(bool? value);
typedef TaskVoidCallback = void Function();

/// Reusable tile for displaying a TaskEntity with improved visuals.
class TaskListTile extends StatelessWidget {
  final TaskEntity task;
  final TaskToggleCallback onToggleComplete;
  final TaskVoidCallback onEdit;
  final TaskVoidCallback onDelete;

  const TaskListTile({
    super.key,
    required this.task,
    required this.onToggleComplete,
    required this.onEdit,
    required this.onDelete,
  });

  Color _priorityColor(TaskPriority? priority) {
    switch (priority) {
      case TaskPriority.high:
        return Colors.redAccent;
      case TaskPriority.medium:
        return Colors.orangeAccent;
      case TaskPriority.low:
        return Colors.green;
      default:
        return Colors.grey;
    }
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Card(
      elevation: task.isCompleted ? 1 : 2,
      color: task.isCompleted ? Colors.grey[50] : null,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12),
        side: task.isCompleted
            ? BorderSide(color: Colors.grey[300]!, width: 1)
            : BorderSide.none,
      ),
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 10),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Priority indicator
            Container(
              width: 12,
              height: 12,
              margin: const EdgeInsets.only(top: 6, right: 12),
              decoration: BoxDecoration(
                color: _priorityColor(task.priority),
                shape: BoxShape.circle,
              ),
            ),

            // Title and description
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    task.title,
                    style: theme.textTheme.titleMedium?.copyWith(
                      fontWeight: FontWeight.w600,
                      decoration:
                          task.isCompleted ? TextDecoration.lineThrough : null,
                      color: task.isCompleted ? Colors.grey[600] : null,
                    ),
                    overflow: TextOverflow.ellipsis,
                  ),
                  const SizedBox(height: 6),
                  Text(
                    task.description,
                    style: theme.textTheme.bodyMedium?.copyWith(
                      color: task.isCompleted
                          ? Colors.grey[500]
                          : theme.textTheme.bodySmall?.color
                              ?.withAlpha((0.9 * 255).round()),
                    ),
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                  ),
                  const SizedBox(height: 8),
                  Row(
                    children: [
                      Chip(
                        label: Text(
                          task.priority
                              .toString()
                              .split('.')
                              .last
                              .toUpperCase(),
                          style: const TextStyle(
                              fontSize: 12, color: Colors.white),
                        ),
                        backgroundColor: _priorityColor(task.priority),
                        visualDensity: VisualDensity.compact,
                      ),
                      const SizedBox(width: 8),
                      if (task.isCompleted) ...[
                        const Icon(Icons.check_circle,
                            color: Colors.green, size: 18),
                        const SizedBox(width: 4),
                        const Text('Completed', style: TextStyle(fontSize: 12)),
                      ],
                    ],
                  )
                ],
              ),
            ),

            // Actions: checkbox + menu
            Column(
              children: [
                Checkbox(
                  value: task.isCompleted,
                  onChanged: onToggleComplete,
                ),
                PopupMenuButton<String>(
                  onSelected: (v) {
                    if (v == 'edit') return onEdit();
                    if (v == 'delete') return onDelete();
                  },
                  itemBuilder: (context) => const [
                    PopupMenuItem(
                        value: 'edit',
                        child: Row(
                          children: [
                            Icon(Icons.edit),
                            SizedBox(width: 8),
                            Text('Edit')
                          ],
                        )),
                    PopupMenuItem(
                        value: 'delete',
                        child: Row(
                          children: [
                            Icon(Icons.delete),
                            SizedBox(width: 8),
                            Text('Delete')
                          ],
                        )),
                  ],
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
