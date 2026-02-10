import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:organize_it/features/tasks/domain/entities/task.dart';
import 'package:organize_it/features/tasks/presentation/widgets/task_list_tile.dart';

void main() {
  group('TaskListTile', () {
    testWidgets('renders title and description', (tester) async {
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
          home: Scaffold(
            body: TaskListTile(
              task: task,
              onToggleComplete: (_) {},
              onEdit: () {},
              onDelete: () {},
            ),
          ),
        ),
      );

      expect(find.text('Title'), findsOneWidget);
      expect(find.text('Desc'), findsOneWidget);
    });

    testWidgets('checkbox toggles', (tester) async {
      var isCompleted = false;
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
          home: Scaffold(
            body: TaskListTile(
              task: task,
              onToggleComplete: (value) => isCompleted = value ?? false,
              onEdit: () {},
              onDelete: () {},
            ),
          ),
        ),
      );

      await tester.tap(find.byType(Checkbox));
      await tester.pumpAndSettle();

      expect(isCompleted, isTrue);
    });

    testWidgets('menu triggers edit and delete', (tester) async {
      var editCalled = false;
      var deleteCalled = false;
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
          home: Scaffold(
            body: TaskListTile(
              task: task,
              onToggleComplete: (_) {},
              onEdit: () => editCalled = true,
              onDelete: () => deleteCalled = true,
            ),
          ),
        ),
      );

      await tester.tap(find.byType(PopupMenuButton<String>));
      await tester.pumpAndSettle();
      await tester.tap(find.text('Edit'));
      await tester.pumpAndSettle();

      await tester.tap(find.byType(PopupMenuButton<String>));
      await tester.pumpAndSettle();
      await tester.tap(find.text('Delete'));
      await tester.pumpAndSettle();

      expect(editCalled, isTrue);
      expect(deleteCalled, isTrue);
    });
  });
}
