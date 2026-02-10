import 'package:flutter_test/flutter_test.dart';
import 'package:organize_it/features/tasks/domain/entities/task.dart';

void main() {
  group('TaskEntity', () {
    test('copyWith overrides selected fields', () {
      const original = TaskEntity(
        id: '1',
        title: 'A',
        description: 'B',
        isCompleted: false,
        priority: TaskPriority.low,
        ownerId: 'user',
      );

      final updated = original.copyWith(title: 'C', isCompleted: true);

      expect(updated.title, 'C');
      expect(updated.isCompleted, isTrue);
      expect(updated.description, 'B');
      expect(updated.priority, TaskPriority.low);
    });

    test('toJson uses server enum names', () {
      const entity = TaskEntity(
        id: '1',
        title: 'A',
        description: 'B',
        isCompleted: false,
        priority: TaskPriority.high,
        ownerId: 'user',
      );

      final json = entity.toJson();

      expect(json['priority'], 'HIGH');
    });

    test('fromJson parses priority from server name', () {
      final json = <String, dynamic>{
        'id': '1',
        'title': 'A',
        'description': 'B',
        'isCompleted': false,
        'priority': 'MEDIUM',
        'ownerId': 'user',
      };

      final entity = TaskEntity.fromJson(json);

      expect(entity.priority, TaskPriority.medium);
    });

    test('fromJson tolerates numeric priority', () {
      final json = <String, dynamic>{
        'id': '1',
        'title': 'A',
        'description': 'B',
        'isCompleted': false,
        'priority': '2',
        'ownerId': 'user',
      };

      final entity = TaskEntity.fromJson(json);

      expect(entity.priority, TaskPriority.low);
    });
  });
}
