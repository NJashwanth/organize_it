import 'package:organize_it/features/tasks/data/datasources/task_datasource.dart';

import '../../domain/entities/task.dart';

class TaskRepository {
  final TaskDatasource _taskDatasource = TaskDatasource();
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

  // get task by id
  Future<TaskEntity?> getTaskById(String id) async {
   return await _taskDatasource.getTaskById(id);
  }


}
