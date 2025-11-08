import 'package:freezed_annotation/freezed_annotation.dart';
import '../../domain/entities/task.dart';

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
    );
  }
}

// Extension for custom methods
extension TaskModelX on TaskModel {
  Map<String, dynamic> toMap() => {
        'title': title,
        'description': description,
        'isCompleted': isCompleted,
        'priority': priority.index,
      };

  TaskEntity toEntity() {
    return TaskEntity(
      id: id,
      title: title,
      description: description,
      isCompleted: isCompleted,
      priority: priority,
    );
  }
}

// Helper to robustly parse priority values coming from various backend formats
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

  // If it's a string, try to match by name (case-insensitive)
  final rawStr = raw.toString().toLowerCase();
  for (final p in TaskPriority.values) {
    if (p.toString().split('.').last.toLowerCase() == rawStr) {
      return p;
    }
  }

  // Fallback
  return TaskPriority.low;
}
