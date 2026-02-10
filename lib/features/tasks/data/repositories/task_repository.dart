import 'package:organize_it/features/tasks/data/datasources/task_datasource.dart';
import 'package:organize_it/features/tasks/domain/entities/task.dart';

// ================================
// REPOSITORY
// ================================
class TaskRepository {
  // Data source bridges API calls and domain entities.
  final TaskDatasource _taskDatasource;

  TaskRepository({TaskDatasource? taskDatasource})
    : _taskDatasource = taskDatasource ?? TaskDatasource();
  Future<List<TaskEntity>> getTasks() async {
    return await _taskDatasource.getTasks();
  }

  Future<void> addTask(TaskEntity task) async {
    return await _taskDatasource.addTask(task);
  }

  Future<void> updateTask(String id, Map<String, dynamic> updates) async {
    return await _taskDatasource.updateTask(id, updates);
  }

  Future<void> deleteTask(String id) async {
    return await _taskDatasource.deleteTask(id);
  }

  // Fetch a single task by id.
  Future<TaskEntity?> getTaskById(String id) async {
    return await _taskDatasource.getTaskById(id);
  }
}
