import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:organize_it/features/tasks/data/datasources/task_datasource.dart';
import 'package:organize_it/features/tasks/data/repositories/task_repository.dart';
import 'package:organize_it/features/tasks/domain/entities/task.dart';

class _MockTaskDatasource extends Mock implements TaskDatasource {}

void main() {
  group('TaskRepository', () {
    late _MockTaskDatasource datasource;
    late TaskRepository repository;

    setUp(() {
      datasource = _MockTaskDatasource();
      repository = TaskRepository(taskDatasource: datasource);
    });

    test('getTasks delegates to datasource', () async {
      when(() => datasource.getTasks()).thenAnswer((_) async => <TaskEntity>[]);

      await repository.getTasks();

      verify(() => datasource.getTasks()).called(1);
    });

    test('addTask delegates to datasource', () async {
      const task = TaskEntity(
        id: '1',
        title: 'A',
        description: 'B',
        isCompleted: false,
        priority: TaskPriority.low,
        ownerId: 'user',
      );
      when(() => datasource.addTask(task)).thenAnswer((_) async {});

      await repository.addTask(task);

      verify(() => datasource.addTask(task)).called(1);
    });

    test('updateTask delegates to datasource', () async {
      when(
        () => datasource.updateTask('1', {'title': 'A'}),
      ).thenAnswer((_) async {});

      await repository.updateTask('1', {'title': 'A'});

      verify(() => datasource.updateTask('1', {'title': 'A'})).called(1);
    });

    test('deleteTask delegates to datasource', () async {
      when(() => datasource.deleteTask('1')).thenAnswer((_) async {});

      await repository.deleteTask('1');

      verify(() => datasource.deleteTask('1')).called(1);
    });

    test('getTaskById delegates to datasource', () async {
      const entity = TaskEntity(
        id: '1',
        title: 'A',
        description: 'B',
        isCompleted: false,
        priority: TaskPriority.low,
        ownerId: 'user',
      );
      when(() => datasource.getTaskById('1')).thenAnswer((_) async => entity);

      final result = await repository.getTaskById('1');

      expect(result, entity);
      verify(() => datasource.getTaskById('1')).called(1);
    });
  });
}
