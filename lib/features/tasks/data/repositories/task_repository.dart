import 'package:organize_it/features/tasks/data/models/task_model.dart';
import 'package:organize_it/services/dio_service.dart';

import '../../domain/entities/task.dart';

class TaskRepository {

  final DioService _dioService = DioService();

  Future<List<TaskEntity>> getTasks() async {
   final response = await _dioService.getRequest('/tasks');
    final List<TaskEntity> tasks = <TaskEntity>[];
    for (final task in response.data) {
      tasks.add(TaskModel.fromMap(task, task['id']));
    }
    return tasks;

  }

  Future<void> addTask(TaskEntity task) async {
    final Map<String, dynamic> data = (task as TaskModel).toMap();
    await _dioService.postRequest('/tasks', data: data);
  }

  Future<void> updateTask(String id, Map<String, dynamic> updates) async {
    final Map<String, dynamic> data = <String, dynamic>{'id': id, ...updates};
    await _dioService.putRequest('/tasks/$id', data: data);
  }

  Future<void> deleteTask(String id) async {
    await _dioService.deleteRequest('/tasks/$id');
  }
}
