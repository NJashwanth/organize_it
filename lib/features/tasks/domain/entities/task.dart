import 'package:equatable/equatable.dart';

enum TaskPriority { high, medium, low }

class TaskEntity extends Equatable {
  final String id;
  final String title;
  final String description;
  final bool isCompleted;
  final TaskPriority priority;

  const TaskEntity({
    required this.id,
    required this.title,
    required this.description,
    required this.isCompleted,
    required this.priority,
  });

  @override
  List<Object?> get props =>
      <Object?>[id, title, description, isCompleted, priority];
}
