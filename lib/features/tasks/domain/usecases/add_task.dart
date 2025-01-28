import '../entities/task.dart';
import '../../data/repositories/task_repository.dart';

class AddTaskUseCase {
  final TaskRepository repository;

  AddTaskUseCase(this.repository);

  Future<void> call(TaskEntity task) async {
    await repository.addTask(task);
  }
}
