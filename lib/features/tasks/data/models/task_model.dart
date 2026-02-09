import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:organize_it/features/tasks/domain/entities/task.dart';

part 'task_model.freezed.dart';
part 'task_model.g.dart';

@freezed
abstract class TaskModel with _$TaskModel {
  const factory TaskModel({
    required String id,
    required String title,
    required String description,
    required bool isCompleted,
    required TaskPriority priority,
    // Backend fields
    String? groupId,
    required String ownerId,
    DateTime? createdAt,
    DateTime? updatedAt,
  }) = _TaskModel;

  factory TaskModel.fromJson(Map<String, dynamic> json) =>
      _$TaskModelFromJson(json);

  factory TaskModel.fromMap(Map<String, dynamic> map, String id) {
    return TaskModel(
      id: id,
      title: map['title'] ?? '',
      description: map['description'] ?? '',
      isCompleted: map['isCompleted'] ?? false,
      priority: _parsePriority(map['priority']),
      groupId: map['groupId']?.toString(),
      ownerId: map['ownerId']?.toString() ?? '',
      createdAt: map['createdAt'] is DateTime
          ? map['createdAt'] as DateTime
          : (map['createdAt'] != null
                ? DateTime.tryParse(map['createdAt'].toString())
                : null),
      updatedAt: map['updatedAt'] is DateTime
          ? map['updatedAt'] as DateTime
          : (map['updatedAt'] != null
                ? DateTime.tryParse(map['updatedAt'].toString())
                : null),
    );
  }
}

// Extension for custom mapping methods.
extension TaskModelX on TaskModel {
  Map<String, dynamic> toMap() => {
    'title': title,
    'description': description,
    'isCompleted': isCompleted,
    // Use the canonical server name provided by the TaskPriority extension.
    'priority': priority.serverName,
    'groupId': groupId,
    'ownerId': ownerId,
    'createdAt': createdAt?.toUtc().toIso8601String(),
    'updatedAt': updatedAt?.toUtc().toIso8601String(),
  };

  TaskEntity toEntity() {
    return TaskEntity(
      id: id,
      title: title,
      description: description,
      isCompleted: isCompleted,
      priority: priority,
      groupId: groupId,
      ownerId: ownerId,
      createdAt: createdAt,
      updatedAt: updatedAt,
    );
  }
}

// Helper to robustly parse priority values coming from various backend formats.
TaskPriority _parsePriority(dynamic raw) {
  if (raw == null) return TaskPriority.low;

  // If it's an int or a numeric string, try parsing as an index
  try {
    final intIndex = raw is int ? raw : int.tryParse(raw.toString());
    if (intIndex != null &&
        intIndex >= 0 &&
        intIndex < TaskPriority.values.length) {
      return TaskPriority.values[intIndex];
    }
  } catch (_) {}

  // If it's a string, try to match by either serverName (uppercase) or friendly name (case-insensitive)
  final rawStr = raw.toString();
  final rawUpper = rawStr.toUpperCase();
  for (final p in TaskPriority.values) {
    if (p.serverName == rawUpper) {
      return p;
    }
    if (p.toString().split('.').last.toLowerCase() == rawStr.toLowerCase()) {
      return p;
    }
  }

  // Fallback
  return TaskPriority.low;
}
