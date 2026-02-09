import 'package:organize_it/features/tasks/data/models/task_model.dart';
import 'package:organize_it/features/tasks/domain/entities/task.dart';
import 'package:organize_it/services/dio_service.dart';

// ================================
// REMOTE DATA SOURCE
// ================================
class TaskDatasource {
  final DioService _dioService = DioService();

  Future<List<TaskEntity>> getTasks() async {
    try {
      final response = await _dioService.getRequest('/tasks');
      final List<TaskEntity> tasks = <TaskEntity>[];
      for (final task in response.data) {
        // Normalize raw payloads into domain entities.
        tasks.add(TaskModel.fromMap(task, task['id']).toEntity());
      }
      return tasks;
    } on Exception catch (e) {
      throw Exception('Failed to load tasks: $e');
    }
  }

  Future<List<TaskEntity>> getTasksByDate(String date) async {
    try {
      final response = await _dioService.getRequest(
        '/tasks',
        queryParameters: {'date': date},
      );
      final List<TaskEntity> tasks = <TaskEntity>[];
      for (final task in response.data) {
        // Normalize raw payloads into domain entities.
        tasks.add(TaskModel.fromMap(task, task['id']).toEntity());
      }
      return tasks;
    } on Exception catch (e) {
      throw Exception('Failed to load tasks: $e');
    }
  }

  Future<void> addTask(TaskEntity task) async {
    // Convert TaskEntity to TaskModel for serialization.
    final TaskModel taskModel = TaskModel(
      id: task.id,
      title: task.title,
      description: task.description,
      isCompleted: task.isCompleted,
      priority: task.priority,
      ownerId: task.ownerId,
    );
    await _dioService.postRequest('/tasks', data: taskModel.toMap());
  }

  Future<void> updateTask(String id, Map<String, dynamic> updates) async {
    // Merge id into update payload to satisfy the API contract.
    final Map<String, dynamic> data = <String, dynamic>{'id': id, ...updates};
    await _dioService.putRequest('/tasks/$id', data: data);
  }

  Future<void> deleteTask(String id) async {
    await _dioService.deleteRequest('/tasks/$id');
  }

  Future<TaskEntity> getTaskById(String id) async {
    try {
      final response = await _dioService.getRequest('/tasks/$id');
      return TaskModel.fromMap(response.data, id).toEntity();
    } on Exception catch (e) {
      throw Exception('Failed to load task: $e');
    }
  }
}
