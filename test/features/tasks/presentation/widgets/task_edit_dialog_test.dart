import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:organize_it/features/tasks/domain/entities/task.dart';
import 'package:organize_it/features/tasks/presentation/widgets/task_edit_dialog.dart';

void main() {
  group('TaskEditDialog', () {
    testWidgets('shows task values', (tester) async {
      const task = TaskEntity(
        id: '1',
        title: 'Title',
        description: 'Desc',
        isCompleted: false,
        priority: TaskPriority.low,
        ownerId: 'user',
      );

      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(body: TaskEditDialog(task: task)),
        ),
      );

      expect(find.text('Title'), findsWidgets);
      expect(find.text('Desc'), findsWidgets);
    });

    testWidgets('returns result on save', (tester) async {
      const task = TaskEntity(
        id: '1',
        title: 'Title',
        description: 'Desc',
        isCompleted: false,
        priority: TaskPriority.low,
        ownerId: 'user',
      );

      TaskEditResult? result;
      await tester.pumpWidget(
        MaterialApp(
          home: Builder(
            builder: (context) {
              return Scaffold(
                body: Center(
                  child: ElevatedButton(
                    onPressed: () async {
                      result = await showDialog<TaskEditResult>(
                        context: context,
                        builder: (_) => TaskEditDialog(task: task),
                      );
                    },
                    child: const Text('Open'),
                  ),
                ),
              );
            },
          ),
        ),
      );

      await tester.tap(find.text('Open'));
      await tester.pumpAndSettle();
      await tester.enterText(find.byType(TextFormField).first, 'Updated');
      await tester.tap(find.text('Save Changes'));
      await tester.pumpAndSettle();

      expect(result?.title, 'Updated');
    });
  });
}
