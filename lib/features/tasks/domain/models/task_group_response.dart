import 'package:equatable/equatable.dart';
import '../entities/task.dart';

/// Response object that contains a TaskGroup plus the expanded list of TaskEntity
/// objects. Mirrors backend TaskGroupResponse.
class TaskGroupResponse extends Equatable {
  final String id;
  final String name;
  final String? description;
  final DateTime? createdAt;
  final DateTime? updatedAt;
  final List<TaskEntity> tasks;

  const TaskGroupResponse({
    required this.id,
    required this.name,
    this.description,
    this.createdAt,
    this.updatedAt,
    this.tasks = const [],
  });

  factory TaskGroupResponse.fromJson(Map<String, dynamic> json) {
    DateTime? parseDt(Object? v) {
      if (v == null) return null;
      try {
        return DateTime.parse(v.toString()).toLocal();
      } catch (_) {
        return null;
      }
    }

    final List<dynamic>? rawTasks = json['tasks'] as List<dynamic>?;

    return TaskGroupResponse(
      id: json['id']?.toString() ?? json['_id']?.toString() ?? '',
      name: json['name']?.toString() ?? '',
      description: json['description']?.toString(),
      createdAt: parseDt(json['createdAt']),
      updatedAt: parseDt(json['updatedAt']),
      tasks: rawTasks != null
          ? rawTasks
              .map((e) => TaskEntity.fromJson(e as Map<String, dynamic>))
              .toList()
          : const [],
    );
  }

  Map<String, dynamic> toJson() => {
        'id': id,
        'name': name,
        'description': description,
        'createdAt': createdAt?.toUtc().toIso8601String(),
        'updatedAt': updatedAt?.toUtc().toIso8601String(),
        'tasks': tasks.map((t) => t.toJson()).toList(),
      };

  @override
  List<Object?> get props =>
      [id, name, description, createdAt, updatedAt, tasks];
}
