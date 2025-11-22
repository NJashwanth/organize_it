import 'package:flutter/material.dart';
import 'package:organize_it/core/theme/app_theme.dart';
import 'package:organize_it/features/tasks/domain/entities/task.dart';

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

  Color _priorityColor(TaskPriority? priority, BuildContext context) {
    final colors = Theme.of(context).colorScheme;
    switch (priority) {
      case TaskPriority.high:
        return colors.highPriority;
      case TaskPriority.medium:
        return colors.mediumPriority;
      case TaskPriority.low:
        return colors.lowPriority;
      default:
        return colors.outline;
    }
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final colors = theme.colorScheme;
    final texts = theme.textTheme;

    return Card(
      elevation: task.isCompleted ? 0 : 1,
      color: task.isCompleted
          ? colors.completedTileBackground
          : colors.tileBackground,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12),
        side: BorderSide(
          color:
              task.isCompleted ? colors.completedTileBorder : colors.tileBorder,
          width: task.isCompleted ? 1 : 0.5,
        ),
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
                color: _priorityColor(task.priority, context),
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
                    style: task.isCompleted
                        ? texts.listTitle.copyWith(
                            decoration: TextDecoration.lineThrough,
                            color: colors.statusCompleted,
                          )
                        : texts.listTitle.copyWith(
                            color: colors.primaryText,
                          ),
                    overflow: TextOverflow.ellipsis,
                  ),
                  const SizedBox(height: 6),
                  Text(
                    task.description,
                    style: task.isCompleted
                        ? texts.listDescription.copyWith(
                            color: colors.disabledText,
                          )
                        : texts.listDescription.copyWith(
                            color: colors.secondaryText,
                          ),
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                  ),
                  const SizedBox(height: 8),
                  Row(
                    children: [
                      Container(
                        padding: const EdgeInsets.symmetric(
                          horizontal: 8,
                          vertical: 4,
                        ),
                        decoration: BoxDecoration(
                          color:
                              _priorityColor(task.priority, context).withValues(
                            alpha: task.isCompleted ? 0.6 : 0.9,
                          ),
                          borderRadius: BorderRadius.circular(12),
                        ),
                        child: Text(
                          task.priority
                              .toString()
                              .split('.')
                              .last
                              .toUpperCase(),
                          style: theme.textTheme.labelSmall?.copyWith(
                            color: Colors.white,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                      ),
                      const SizedBox(width: 8),
                      if (task.isCompleted) ...[
                        Icon(
                          Icons.check_circle_outline,
                          color:
                              theme.colorScheme.primary.withValues(alpha: 0.7),
                          size: 16,
                        ),
                        const SizedBox(width: 4),
                        Text(
                          'Completed',
                          style: theme.textTheme.labelSmall?.copyWith(
                            color: theme.colorScheme.onSurfaceVariant
                                .withValues(alpha: 0.8),
                          ),
                        ),
                      ],
                    ],
                  ),
                ],
              ),
            ),

            // Actions: checkbox + menu
            Column(
              children: [
                Transform.scale(
                  scale: 0.9,
                  child: Checkbox(
                    value: task.isCompleted,
                    onChanged: onToggleComplete,
                    activeColor:
                        theme.colorScheme.primary.withValues(alpha: 0.9),
                    checkColor: theme.colorScheme.onPrimary,
                  ),
                ),
                PopupMenuButton<String>(
                  onSelected: (v) {
                    if (v == 'edit') return onEdit();
                    if (v == 'delete') return onDelete();
                  },
                  icon: Icon(
                    Icons.more_vert,
                    color: theme.colorScheme.onSurfaceVariant,
                    size: 20,
                  ),
                  itemBuilder: (context) => [
                    PopupMenuItem(
                      value: 'edit',
                      child: Row(
                        children: [
                          Icon(
                            Icons.edit_outlined,
                            size: 20,
                            color: theme.colorScheme.onSurface,
                          ),
                          const SizedBox(width: 8),
                          Text(
                            'Edit',
                            style: theme.textTheme.labelLarge?.copyWith(
                              color: theme.colorScheme.onSurface,
                            ),
                          ),
                        ],
                      ),
                    ),
                    PopupMenuItem(
                      value: 'delete',
                      child: Row(
                        children: [
                          Icon(
                            Icons.delete_outline,
                            size: 20,
                            color: theme.colorScheme.error,
                          ),
                          const SizedBox(width: 8),
                          Text(
                            'Delete',
                            style: theme.textTheme.labelLarge?.copyWith(
                              color: theme.colorScheme.error,
                            ),
                          ),
                        ],
                      ),
                    ),
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
