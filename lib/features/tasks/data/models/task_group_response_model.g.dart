// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'task_group_response_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_TaskGroupResponseModel _$TaskGroupResponseModelFromJson(
  Map<String, dynamic> json,
) => _TaskGroupResponseModel(
  id: json['id'] as String,
  name: json['name'] as String,
  description: json['description'] as String?,
  createdAt: json['createdAt'] == null
      ? null
      : DateTime.parse(json['createdAt'] as String),
  updatedAt: json['updatedAt'] == null
      ? null
      : DateTime.parse(json['updatedAt'] as String),
  tasks:
      (json['tasks'] as List<dynamic>?)
          ?.map((e) => TaskModel.fromJson(e as Map<String, dynamic>))
          .toList() ??
      const <TaskModel>[],
);

Map<String, dynamic> _$TaskGroupResponseModelToJson(
  _TaskGroupResponseModel instance,
) => <String, dynamic>{
  'id': instance.id,
  'name': instance.name,
  'description': instance.description,
  'createdAt': instance.createdAt?.toIso8601String(),
  'updatedAt': instance.updatedAt?.toIso8601String(),
  'tasks': instance.tasks,
};
