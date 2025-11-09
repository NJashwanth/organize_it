import 'package:equatable/equatable.dart';

/// Represents a TaskGroup from the backend in the Flutter app.
class TaskGroup extends Equatable {
  final String id;
  final String name;
  final String? description;
  final DateTime? createdAt;
  final DateTime? updatedAt;
  final List<String> tasksList;
  final String ownerId;
  final bool isActive;

  const TaskGroup({
    required this.id,
    required this.name,
    this.description,
    this.createdAt,
    this.updatedAt,
    this.tasksList = const [],
    required this.ownerId,
    this.isActive = true,
  });

  factory TaskGroup.fromJson(Map<String, dynamic> json) {
    DateTime? parseDt(Object? v) {
      if (v == null) return null;
      try {
        return DateTime.parse(v.toString()).toLocal();
      } catch (_) {
        return null;
      }
    }

    final List<dynamic>? raw = json['tasksList'] as List<dynamic>?;

    return TaskGroup(
      id: json['id']?.toString() ?? json['_id']?.toString() ?? '',
      name: json['name']?.toString() ?? '',
      description: json['description']?.toString(),
      createdAt: parseDt(json['createdAt']),
      updatedAt: parseDt(json['updatedAt']),
      tasksList: raw?.map((e) => e.toString()).toList() ?? [],
      ownerId: json['ownerId']?.toString() ?? '',
      isActive: json['isActive'] == null
          ? true
          : (json['isActive'] == true || json['isActive'] == 'true'),
    );
  }

  Map<String, dynamic> toJson() => {
        'id': id,
        'name': name,
        'description': description,
        'createdAt': createdAt?.toUtc().toIso8601String(),
        'updatedAt': updatedAt?.toUtc().toIso8601String(),
        'tasksList': tasksList,
        'ownerId': ownerId,
        'isActive': isActive,
      };

  @override
  List<Object?> get props => [
        id,
        name,
        description,
        createdAt,
        updatedAt,
        tasksList,
        ownerId,
        isActive
      ];
}
