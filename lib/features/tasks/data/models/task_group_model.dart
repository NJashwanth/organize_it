import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:organize_it/features/tasks/domain/models/task_group.dart' as domain;

part 'task_group_model.freezed.dart';
part 'task_group_model.g.dart';

@freezed
abstract class TaskGroupModel with _$TaskGroupModel {
  const factory TaskGroupModel({
    required String id,
    required String name,
    String? description,
    DateTime? createdAt,
    DateTime? updatedAt,
    @Default(<String>[]) List<String> tasksList,
    required String ownerId,
    @Default(true) bool isActive,
  }) = _TaskGroupModel;

  factory TaskGroupModel.fromJson(Map<String, dynamic> json) =>
      _$TaskGroupModelFromJson(json);
}

extension TaskGroupModelX on TaskGroupModel {
  domain.TaskGroup toDomain() => domain.TaskGroup(
        id: id,
        name: name,
        description: description,
        createdAt: createdAt,
        updatedAt: updatedAt,
        tasksList: tasksList,
        ownerId: ownerId,
        isActive: isActive,
      );

  static TaskGroupModel fromDomain(domain.TaskGroup g) => TaskGroupModel(
        id: g.id,
        name: g.name,
        description: g.description,
        createdAt: g.createdAt,
        updatedAt: g.updatedAt,
        tasksList: g.tasksList,
        ownerId: g.ownerId,
        isActive: g.isActive,
      );
}
