import 'package:flutter_test/flutter_test.dart';
import 'package:organize_it/features/tasks/data/models/task_group_model.dart';
import 'package:organize_it/features/tasks/domain/models/task_group.dart'
    as domain;

void main() {
  group('TaskGroupModel', () {
    test('toDomain maps fields', () {
      const model = TaskGroupModel(
        id: '1',
        name: 'Group',
        ownerId: 'user',
        tasksList: ['a'],
        isActive: false,
      );

      final entity = model.toDomain();

      expect(entity, isA<domain.TaskGroup>());
      expect(entity.name, 'Group');
      expect(entity.isActive, isFalse);
    });

    test('fromDomain maps fields', () {
      const entity = domain.TaskGroup(
        id: '1',
        name: 'Group',
        ownerId: 'user',
        tasksList: ['a'],
        isActive: true,
      );

      final model = TaskGroupModelX.fromDomain(entity);

      expect(model.name, 'Group');
      expect(model.isActive, isTrue);
    });
  });
}
