import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../data/repositories/task_repository.dart';
import '../../domain/entities/task.dart';

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
    state = await repository.getTasks();
  }

  Future<void> addTask(TaskEntity task) async {
    await repository.addTask(task);
    await loadTasks();
  }

  Future<void> updateTask(String id, Map<String, dynamic> updates) async {
    await repository.updateTask(id, updates);
    await loadTasks();
  }

  Future<void> deleteTask(String id) async {
    await repository.deleteTask(id);
    await loadTasks();
  }
}
