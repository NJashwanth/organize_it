import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:organize_it/features/tasks/domain/entities/task.dart';
import 'package:organize_it/features/tasks/presentation/providers/task_provider.dart';
import 'package:organize_it/features/tasks/presentation/screens/task_create_screen.dart';

class _CapturingTasksNotifier extends Tasks {
  final List<TaskEntity> added = <TaskEntity>[];

  @override
  AsyncValue<List<TaskEntity>> build() => const AsyncValue.data(<TaskEntity>[]);

  @override
  Future<void> addTask(TaskEntity task) async {
    added.add(task);
  }
}

void main() {
  group('TaskCreateScreen', () {
    testWidgets('validates title is required', (tester) async {
      final notifier = _CapturingTasksNotifier();

      await tester.pumpWidget(
        ProviderScope(
          overrides: [tasksProvider.overrideWith(() => notifier)],
          child: const MaterialApp(home: TaskCreateScreen()),
        ),
      );

      await tester.tap(find.text('Submit'));
      await tester.pump();

      expect(find.text('Please enter a title'), findsOneWidget);
    });

    testWidgets('submits task and closes', (tester) async {
      final notifier = _CapturingTasksNotifier();

      await tester.pumpWidget(
        ProviderScope(
          overrides: [tasksProvider.overrideWith(() => notifier)],
          child: const MaterialApp(home: TaskCreateScreen()),
        ),
      );

      await tester.enterText(
        find.widgetWithText(TextFormField, 'Title'),
        'Title',
      );
      await tester.enterText(
        find.widgetWithText(TextFormField, 'Description'),
        'Desc',
      );
      await tester.tap(find.text('Submit'));
      await tester.pumpAndSettle();

      expect(notifier.added, hasLength(1));
      expect(notifier.added.first.title, 'Title');
    });
  });
}
