import 'package:flutter/material.dart';
import '../../domain/entities/task.dart';

class TaskEditResult {
  final String title;
  final String description;
  final TaskPriority? priority;

  const TaskEditResult({
    required this.title,
    required this.description,
    this.priority,
  });
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
    final theme = Theme.of(context);
    final size = MediaQuery.of(context).size;
    final isSmallScreen = size.width < 600; // Responsive breakpoint

    Widget buildForm() {
      return Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Header
          if (!isSmallScreen) ...[
            Row(
              children: [
                Icon(Icons.edit, size: 24, color: theme.colorScheme.primary),
                const SizedBox(width: 12),
                Text(
                  'Edit Task',
                  style: theme.textTheme.titleLarge?.copyWith(
                    fontWeight: FontWeight.w600,
                    color: theme.colorScheme.onSurface,
                  ),
                ),
              ],
            ),
            const SizedBox(height: 24),
          ],

          // Title Field
          TextFormField(
            controller: _titleController,
            decoration: InputDecoration(
              labelText: 'Title',
              hintText: 'Enter task title',
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(12),
              ),
              prefixIcon:
                  Icon(Icons.title, color: theme.colorScheme.onSurfaceVariant),
            ),
            validator: (v) =>
                v == null || v.trim().isEmpty ? 'Title is required' : null,
            textInputAction: TextInputAction.next,
          ),
          const SizedBox(height: 16),

          // Description Field
          TextFormField(
            controller: _descriptionController,
            decoration: InputDecoration(
              labelText: 'Description',
              hintText: 'Enter task description',
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(12),
              ),
              prefixIcon: Icon(Icons.description,
                  color: theme.colorScheme.onSurfaceVariant),
            ),
            maxLines: 3,
            textInputAction: TextInputAction.newline,
          ),
          const SizedBox(height: 16),

          // Priority Field
          DropdownButtonFormField<TaskPriority>(
            initialValue: _selectedPriority,
            decoration: InputDecoration(
              labelText: 'Priority',
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(12),
              ),
              prefixIcon:
                  Icon(Icons.flag, color: theme.colorScheme.onSurfaceVariant),
            ),
            items: TaskPriority.values.map((p) {
              final color = p == TaskPriority.high
                  ? theme.colorScheme.error
                  : p == TaskPriority.medium
                      ? theme.colorScheme.tertiary
                      : theme.colorScheme.primary;
              return DropdownMenuItem(
                value: p,
                child: Row(
                  children: [
                    Icon(Icons.circle, size: 12, color: color),
                    const SizedBox(width: 8),
                    Text(
                      p.toString().split('.').last.toUpperCase(),
                      style: theme.textTheme.bodyLarge?.copyWith(
                        color: theme.colorScheme.onSurface,
                      ),
                    ),
                  ],
                ),
              );
            }).toList(),
            onChanged: (p) => setState(() => _selectedPriority = p),
          ),
          const SizedBox(height: 24),

          // Action Buttons
          Row(
            children: [
              Expanded(
                child: OutlinedButton(
                  onPressed: () => Navigator.pop(context),
                  style: OutlinedButton.styleFrom(
                    padding: const EdgeInsets.symmetric(vertical: 16),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                  ),
                  child: const Text('Cancel'),
                ),
              ),
              const SizedBox(width: 12),
              Expanded(
                child: ElevatedButton(
                  onPressed: () {
                    final title = _titleController.text.trim();
                    if (title.isEmpty) {
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(
                          content: const Text('Please enter a title'),
                          behavior: SnackBarBehavior.floating,
                          backgroundColor: theme.colorScheme.error,
                        ),
                      );
                      return;
                    }
                    final result = TaskEditResult(
                      title: title,
                      description: _descriptionController.text.trim(),
                      priority: _selectedPriority,
                    );
                    Navigator.pop(context, result);
                  },
                  style: ElevatedButton.styleFrom(
                    padding: const EdgeInsets.symmetric(vertical: 16),
                    backgroundColor: theme.colorScheme.primary,
                    foregroundColor: theme.colorScheme.onPrimary,
                    elevation: 0,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                  ),
                  child: const Text('Save Changes'),
                ),
              ),
            ],
          ),
        ],
      );
    }

    return isSmallScreen
        ? Dialog.fullscreen(
            child: Scaffold(
              appBar: AppBar(
                title: const Text('Edit Task'),
                backgroundColor: theme.colorScheme.surface,
                leading: IconButton(
                  icon: const Icon(Icons.close),
                  onPressed: () => Navigator.pop(context),
                ),
              ),
              body: SafeArea(
                child: SingleChildScrollView(
                  padding: const EdgeInsets.all(16),
                  child: buildForm(),
                ),
              ),
            ),
          )
        : Dialog(
            backgroundColor: theme.colorScheme.surface,
            elevation: 0,
            child: Container(
              width: 400, // Fixed width for larger screens
              padding: const EdgeInsets.all(24),
              child: buildForm(),
            ),
          );
  }
}
