// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'task_group_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_TaskGroupModel _$TaskGroupModelFromJson(Map<String, dynamic> json) =>
    _TaskGroupModel(
      id: json['id'] as String,
      name: json['name'] as String,
      description: json['description'] as String?,
      createdAt: json['createdAt'] == null
          ? null
          : DateTime.parse(json['createdAt'] as String),
      updatedAt: json['updatedAt'] == null
          ? null
          : DateTime.parse(json['updatedAt'] as String),
      tasksList:
          (json['tasksList'] as List<dynamic>?)
              ?.map((e) => e as String)
              .toList() ??
          const <String>[],
      ownerId: json['ownerId'] as String,
      isActive: json['isActive'] as bool? ?? true,
    );

Map<String, dynamic> _$TaskGroupModelToJson(_TaskGroupModel instance) =>
    <String, dynamic>{
      'id': instance.id,
      'name': instance.name,
      'description': instance.description,
      'createdAt': instance.createdAt?.toIso8601String(),
      'updatedAt': instance.updatedAt?.toIso8601String(),
      'tasksList': instance.tasksList,
      'ownerId': instance.ownerId,
      'isActive': instance.isActive,
    };
