import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../data/repositories/task_repository.dart';
import '../../domain/entities/task.dart';
import '../../data/models/task_model.dart';

final Provider<TaskRepository> taskRepositoryProvider =
    Provider((ref) => TaskRepository());

class TaskNotifier extends Notifier<AsyncValue<List<TaskEntity>>> {
  late final TaskRepository repository;

  @override
  AsyncValue<List<TaskEntity>> build() {
    repository = ref.read(taskRepositoryProvider);
    return const AsyncValue.data(<TaskEntity>[]);
  }

  Future<void> loadTasks() async {
    state = const AsyncValue.loading();
    try {
      final tasks = await repository.getTasks();
      state = AsyncValue.data(tasks);
    } catch (e, st) {
      state = AsyncValue.error(e, st);
    }
  }

  Future<void> addTask(TaskEntity task) async {
    try {
      await repository.addTask(task);
      await loadTasks(); // Reload tasks after adding
    } catch (e, st) {
      state = AsyncValue.error(e, st);
    }
  }

  Future<void> updateTask(TaskEntity task,
      {String? title,
      String? description,
      bool? isCompleted,
      TaskPriority? priority}) async {
    try {
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
    } catch (e, st) {
      state = AsyncValue.error(e, st);
    }
  }

  Future<void> deleteTask(String id) async {
    try {
      await repository.deleteTask(id);
      await loadTasks(); // Reload tasks after deletion
    } catch (e, st) {
      state = AsyncValue.error(e, st);
    }
  }
}

final taskProvider =
    NotifierProvider<TaskNotifier, AsyncValue<List<TaskEntity>>>(
  TaskNotifier.new,
);
