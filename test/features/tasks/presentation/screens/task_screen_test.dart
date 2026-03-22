import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:organize_it/features/tasks/domain/entities/task.dart';
import 'package:organize_it/features/tasks/presentation/providers/task_provider.dart';
import 'package:organize_it/features/tasks/presentation/screens/task_screen.dart';
import 'package:organize_it/core/widgets/organize_it_loading.dart';

class _StaticTasksNotifier extends Tasks {
  _StaticTasksNotifier(this.initialState);

  final AsyncValue<List<TaskEntity>> initialState;

  @override
  AsyncValue<List<TaskEntity>> build() => initialState;

  @override
  Future<void> loadTasks() async {}
}

void main() {
  group('TaskScreen', () {
    testWidgets('shows empty state when no tasks', (tester) async {
      await tester.pumpWidget(
        ProviderScope(
          overrides: [
            tasksProvider.overrideWith(
              () => _StaticTasksNotifier(const AsyncValue.data(<TaskEntity>[])),
            ),
          ],
          child: const MaterialApp(home: TaskScreen()),
        ),
      );

      await tester.pump();

      expect(find.text('No tasks found!'), findsOneWidget);
    });

    testWidgets('shows loading state', (tester) async {
      final container = ProviderContainer(
        overrides: [
          tasksProvider.overrideWith(
            () => _StaticTasksNotifier(const AsyncValue.loading()),
          ),
        ],
      );
      addTearDown(container.dispose);

      await tester.pumpWidget(
        UncontrolledProviderScope(
          container: container,
          child: const MaterialApp(home: TaskScreen()),
        ),
      );

      await tester.pump();

      expect(find.byType(OrganizeItLoading), findsOneWidget);
      expect(find.byType(Scaffold), findsOneWidget);
    });

    testWidgets('shows error state with retry action', (tester) async {
      final container = ProviderContainer(
        overrides: [
          tasksProvider.overrideWith(
            () => _StaticTasksNotifier(
              AsyncValue.error(Exception('boom'), StackTrace.current),
            ),
          ),
        ],
      );
      addTearDown(container.dispose);

      await tester.pumpWidget(
        UncontrolledProviderScope(
          container: container,
          child: const MaterialApp(home: TaskScreen()),
        ),
      );

      await tester.pump();

      expect(find.text('We couldn\'t load your tasks'), findsOneWidget);
      expect(find.text('Try again'), findsOneWidget);
    });

    testWidgets('shows list when tasks exist', (tester) async {
      final container = ProviderContainer(
        overrides: [
          tasksProvider.overrideWith(
            () => _StaticTasksNotifier(
              const AsyncValue.data([
                TaskEntity(
                  id: '1',
                  title: 'A',
                  description: 'B',
                  isCompleted: false,
                  priority: TaskPriority.low,
                  ownerId: 'user',
                ),
              ]),
            ),
          ),
        ],
      );
      addTearDown(container.dispose);

      await tester.pumpWidget(
        UncontrolledProviderScope(
          container: container,
          child: const MaterialApp(home: TaskScreen()),
        ),
      );

      await tester.pump();

      expect(find.text('Active Tasks'), findsOneWidget);
      expect(find.text('A'), findsOneWidget);
    });
  });
}
