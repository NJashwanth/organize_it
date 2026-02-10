import 'package:flutter_test/flutter_test.dart';
import 'package:organize_it/features/tasks/domain/models/task_group.dart';

void main() {
  group('TaskGroup', () {
    test('fromJson parses tasks list and booleans', () {
      final json = <String, dynamic>{
        'id': '1',
        'name': 'Group',
        'tasksList': ['a', 'b'],
        'ownerId': 'user',
        'isActive': 'true',
      };

      final group = TaskGroup.fromJson(json);

      expect(group.tasksList, ['a', 'b']);
      expect(group.isActive, isTrue);
    });

    test('toJson serializes fields', () {
      const group = TaskGroup(
        id: '1',
        name: 'Group',
        ownerId: 'user',
        tasksList: ['a'],
        isActive: false,
      );

      final json = group.toJson();

      expect(json['name'], 'Group');
      expect(json['isActive'], isFalse);
      expect(json['tasksList'], ['a']);
    });
  });
}
