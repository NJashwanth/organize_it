import 'package:flutter_test/flutter_test.dart';
import 'package:organize_it/features/tasks/data/models/task_model.dart';
import 'package:organize_it/features/tasks/domain/entities/task.dart';

void main() {
  group('TaskModel', () {
    test('fromMap parses priority variations', () {
      final map = <String, dynamic>{
        'title': 'A',
        'description': 'B',
        'isCompleted': false,
        'priority': 'HIGH',
        'ownerId': 'user',
      };

      final model = TaskModel.fromMap(map, '1');

      expect(model.priority, TaskPriority.high);
    });

    test('toMap uses server enum names', () {
      const model = TaskModel(
        id: '1',
        title: 'A',
        description: 'B',
        isCompleted: false,
        priority: TaskPriority.medium,
        ownerId: 'user',
      );

      final map = model.toMap();

      expect(map['priority'], 'MEDIUM');
    });

    test('toEntity preserves fields', () {
      const model = TaskModel(
        id: '1',
        title: 'A',
        description: 'B',
        isCompleted: true,
        priority: TaskPriority.low,
        ownerId: 'user',
      );

      final entity = model.toEntity();

      expect(entity.id, '1');
      expect(entity.isCompleted, isTrue);
    });
  });
}
