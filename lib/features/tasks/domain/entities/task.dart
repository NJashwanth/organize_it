import 'package:equatable/equatable.dart';

enum TaskPriority { high, medium, low }

/// Represents a Task as used in the Flutter front-end. Mirrors the backend model.
class TaskEntity extends Equatable {
  final String id;
  final String title;
  final String description;
  final bool isCompleted;
  final TaskPriority priority;

  // New fields from backend model
  final String? groupId;
  final String ownerId;
  final DateTime? createdAt;
  final DateTime? updatedAt;

  const TaskEntity({
    required this.id,
    required this.title,
    required this.description,
    required this.isCompleted,
    required this.priority,
    this.groupId,
    required this.ownerId,
    this.createdAt,
    this.updatedAt,
  });

  /// Create a copy with updated fields.
  TaskEntity copyWith({
    String? id,
    String? title,
    String? description,
    bool? isCompleted,
    TaskPriority? priority,
    String? groupId,
    String? ownerId,
    DateTime? createdAt,
    DateTime? updatedAt,
  }) {
    return TaskEntity(
      id: id ?? this.id,
      title: title ?? this.title,
      description: description ?? this.description,
      isCompleted: isCompleted ?? this.isCompleted,
      priority: priority ?? this.priority,
      groupId: groupId ?? this.groupId,
      ownerId: ownerId ?? this.ownerId,
      createdAt: createdAt ?? this.createdAt,
      updatedAt: updatedAt ?? this.updatedAt,
    );
  }

  /// Deserialize from backend JSON (expects ISO-8601 timestamps for createdAt/updatedAt).
  factory TaskEntity.fromJson(Map<String, dynamic> json) {
    DateTime? parseDt(Object? v) {
      if (v == null) return null;
      try {
        return DateTime.parse(v.toString()).toLocal();
      } catch (_) {
        return null;
      }
    }

    TaskPriority parsePriority(String? p) {
      switch (p) {
        case 'high':
          return TaskPriority.high;
        case 'medium':
          return TaskPriority.medium;
        case 'low':
        default:
          return TaskPriority.low;
      }
    }

    return TaskEntity(
      id: json['id']?.toString() ?? json['_id']?.toString() ?? '',
      title: json['title']?.toString() ?? '',
      description: json['description']?.toString() ?? '',
      isCompleted: json['isCompleted'] == true || json['isCompleted'] == 'true',
      priority: parsePriority(json['priority']?.toString()),
      groupId: json['groupId']?.toString(),
      ownerId: json['ownerId']?.toString() ?? '',
      createdAt: parseDt(json['createdAt']),
      updatedAt: parseDt(json['updatedAt']),
    );
  }

  /// Serialize to JSON suitable for sending to backend.
  Map<String, dynamic> toJson() => {
        'id': id,
        'title': title,
        'description': description,
        'isCompleted': isCompleted,
        'priority': priority.name,
        'groupId': groupId,
        'ownerId': ownerId,
        'createdAt': createdAt?.toUtc().toIso8601String(),
        'updatedAt': updatedAt?.toUtc().toIso8601String(),
      };

  @override
  List<Object?> get props => <Object?>[
        id,
        title,
        description,
        isCompleted,
        priority,
        groupId,
        ownerId,
        createdAt,
        updatedAt,
      ];
}
