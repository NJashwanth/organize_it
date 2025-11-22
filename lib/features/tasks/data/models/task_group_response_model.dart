import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:organize_it/features/tasks/domain/models/task_group_response.dart' as domain;
import 'package:organize_it/features/tasks/data/models/task_model.dart';

part 'task_group_response_model.freezed.dart';
part 'task_group_response_model.g.dart';

@freezed
abstract class TaskGroupResponseModel with _$TaskGroupResponseModel {
  const factory TaskGroupResponseModel({
    required String id,
    required String name,
    String? description,
    DateTime? createdAt,
    DateTime? updatedAt,
    @Default(<TaskModel>[]) List<TaskModel> tasks,
  }) = _TaskGroupResponseModel;

  factory TaskGroupResponseModel.fromJson(Map<String, dynamic> json) =>
      _$TaskGroupResponseModelFromJson(json);
}

extension TaskGroupResponseModelX on TaskGroupResponseModel {
  domain.TaskGroupResponse toDomain() => domain.TaskGroupResponse(
        id: id,
        name: name,
        description: description,
        createdAt: createdAt,
        updatedAt: updatedAt,
        tasks: tasks.map((t) => t.toEntity()).toList(),
      );

  static TaskGroupResponseModel fromDomain(domain.TaskGroupResponse r) =>
      TaskGroupResponseModel(
        id: r.id,
        name: r.name,
        description: r.description,
        createdAt: r.createdAt,
        updatedAt: r.updatedAt,
        tasks: r.tasks
            .map((t) => TaskModel(
                  id: t.id,
                  title: t.title,
                  description: t.description,
                  isCompleted: t.isCompleted,
                  priority: t.priority,
                  groupId: t.groupId,
                  ownerId: t.ownerId,
                  createdAt: t.createdAt,
                  updatedAt: t.updatedAt,
                ),)
            .toList(),
      );
}
