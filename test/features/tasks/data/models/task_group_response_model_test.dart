import 'package:flutter_test/flutter_test.dart';
import 'package:organize_it/features/tasks/data/models/task_group_response_model.dart';
import 'package:organize_it/features/tasks/data/models/task_model.dart';
import 'package:organize_it/features/tasks/domain/entities/task.dart';
import 'package:organize_it/features/tasks/domain/models/task_group_response.dart'
    as domain;

void main() {
  group('TaskGroupResponseModel', () {
    test('toDomain maps tasks', () {
      const model = TaskGroupResponseModel(
        id: '1',
        name: 'Group',
        tasks: [
          TaskModel(
            id: 't1',
            title: 'A',
            description: 'B',
            isCompleted: false,
            priority: TaskPriority.low,
            ownerId: 'user',
          ),
        ],
      );

      final entity = model.toDomain();

      expect(entity, isA<domain.TaskGroupResponse>());
      expect(entity.tasks.first.id, 't1');
    });

    test('fromDomain maps tasks', () {
      const entity = domain.TaskGroupResponse(
        id: '1',
        name: 'Group',
        tasks: [
          TaskEntity(
            id: 't1',
            title: 'A',
            description: 'B',
            isCompleted: false,
            priority: TaskPriority.high,
            ownerId: 'user',
          ),
        ],
      );

      final model = TaskGroupResponseModelX.fromDomain(entity);

      expect(model.tasks.first.priority, TaskPriority.high);
    });
  });
}
