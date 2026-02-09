import 'package:organize_it/features/tasks/domain/entities/task.dart';
import 'package:organize_it/features/tasks/data/repositories/task_repository.dart';

/// Domain-level use case for adding a task.
class AddTaskUseCase {
  final TaskRepository repository;

  AddTaskUseCase(this.repository);

  Future<void> call(TaskEntity task) async {
    await repository.addTask(task);
  }
}
