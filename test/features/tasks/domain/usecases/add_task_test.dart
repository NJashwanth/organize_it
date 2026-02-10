import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:organize_it/features/tasks/data/repositories/task_repository.dart';
import 'package:organize_it/features/tasks/domain/entities/task.dart';
import 'package:organize_it/features/tasks/domain/usecases/add_task.dart';

class _MockTaskRepository extends Mock implements TaskRepository {}

void main() {
  group('AddTaskUseCase', () {
    test('delegates to repository', () async {
      final repository = _MockTaskRepository();
      final useCase = AddTaskUseCase(repository);
      const task = TaskEntity(
        id: '1',
        title: 'A',
        description: 'B',
        isCompleted: false,
        priority: TaskPriority.low,
        ownerId: 'user',
      );

      when(() => repository.addTask(task)).thenAnswer((_) async {});

      await useCase.call(task);

      verify(() => repository.addTask(task)).called(1);
    });
  });
}
