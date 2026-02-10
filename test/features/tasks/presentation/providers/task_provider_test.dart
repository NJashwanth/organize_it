import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:riverpod/riverpod.dart';
import 'package:organize_it/features/tasks/domain/entities/task.dart';
import 'package:organize_it/features/tasks/presentation/providers/task_provider.dart';
import 'package:organize_it/features/tasks/data/repositories/task_repository.dart';

class _MockTaskRepository extends Mock implements TaskRepository {}

void main() {
  setUpAll(() {
    registerFallbackValue(<String, dynamic>{});
  });

  group('Tasks provider', () {
    late ProviderContainer container;
    late _MockTaskRepository repository;

    setUp(() {
      repository = _MockTaskRepository();
      container = ProviderContainer(
        overrides: [taskRepositoryProvider.overrideWithValue(repository)],
      );
      addTearDown(container.dispose);
    });

    test('loadTasks sets data on success', () async {
      when(() => repository.getTasks()).thenAnswer(
        (_) async => <TaskEntity>[
          const TaskEntity(
            id: '1',
            title: 'A',
            description: 'B',
            isCompleted: false,
            priority: TaskPriority.low,
            ownerId: 'user',
          ),
        ],
      );

      final notifier = container.read(tasksProvider.notifier);
      await notifier.loadTasks();

      final state = container.read(tasksProvider);
      expect(state.asData?.value.length, 1);
    });

    test('addTask reloads tasks after adding', () async {
      const task = TaskEntity(
        id: '1',
        title: 'A',
        description: 'B',
        isCompleted: false,
        priority: TaskPriority.low,
        ownerId: 'user',
      );
      when(() => repository.addTask(task)).thenAnswer((_) async {});
      when(() => repository.getTasks()).thenAnswer((_) async => [task]);

      final notifier = container.read(tasksProvider.notifier);
      await notifier.addTask(task);

      final state = container.read(tasksProvider);
      expect(state.asData?.value.first.id, '1');
    });

    test('updateTask sends update payload and reloads', () async {
      const task = TaskEntity(
        id: '1',
        title: 'A',
        description: 'B',
        isCompleted: false,
        priority: TaskPriority.low,
        ownerId: 'user',
      );
      when(
        () => repository.updateTask('1', any<Map<String, dynamic>>()),
      ).thenAnswer((_) async {});
      when(() => repository.getTasks()).thenAnswer((_) async => [task]);

      final notifier = container.read(tasksProvider.notifier);
      await notifier.updateTask(task, title: 'Updated');

      verify(
        () => repository.updateTask('1', any<Map<String, dynamic>>()),
      ).called(1);
      final state = container.read(tasksProvider);
      expect(state.asData?.value.first.title, 'A');
    });

    test('deleteTask reloads after deletion', () async {
      when(() => repository.deleteTask('1')).thenAnswer((_) async {});
      when(() => repository.getTasks()).thenAnswer((_) async => <TaskEntity>[]);

      final notifier = container.read(tasksProvider.notifier);
      await notifier.deleteTask('1');

      final state = container.read(tasksProvider);
      expect(state.asData?.value, isEmpty);
    });
  });
}
