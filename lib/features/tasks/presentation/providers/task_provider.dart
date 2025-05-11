import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../data/repositories/task_repository.dart';
import '../../domain/entities/task.dart';
import '../../data/models/task_model.dart';

final Provider<TaskRepository> taskRepositoryProvider =
    Provider((ref) => TaskRepository());

final StateNotifierProvider<TaskNotifier, List<TaskEntity>> taskProvider =
    StateNotifierProvider<TaskNotifier, List<TaskEntity>>((ref) {
  final TaskRepository repository = ref.watch(taskRepositoryProvider);
  return TaskNotifier(repository);
});

class TaskNotifier extends StateNotifier<List<TaskEntity>> {
  final TaskRepository repository;

  TaskNotifier(this.repository) : super(<TaskEntity>[]);

  Future<void> loadTasks() async {
    final tasks = await repository.getTasks();
    state = tasks;
  }

  Future<void> addTask(TaskEntity task) async {
    await repository.addTask(task);
    await loadTasks(); // Reload tasks after adding
  }

  Future<void> updateTask(TaskEntity task,
      {String? title,
      String? description,
      bool? isCompleted,
      TaskPriority? priority}) async {
    // Use copyWith to update fields
    final updatedTask = task.copyWith(
      title: title ?? task.title,
      description: description ?? task.description,
      isCompleted: isCompleted ?? task.isCompleted,
      priority: priority ?? task.priority,
    );

    // Convert TaskEntity to TaskModel
    final TaskModel taskModel = TaskModel(
      id: updatedTask.id,
      title: updatedTask.title,
      description: updatedTask.description,
      isCompleted: updatedTask.isCompleted,
      priority: updatedTask.priority,
    );

    // Update the task in the repository using TaskModel
    await repository.updateTask(updatedTask.id, taskModel.toMap());

    // Reload tasks to reflect changes in UI
    await loadTasks();
  }

  Future<void> deleteTask(String id) async {
    await repository.deleteTask(id);
    await loadTasks(); // Reload tasks after deletion
  }
}
