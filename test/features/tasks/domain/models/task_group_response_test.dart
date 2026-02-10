import 'package:flutter_test/flutter_test.dart';
import 'package:organize_it/features/tasks/domain/models/task_group_response.dart';

void main() {
  group('TaskGroupResponse', () {
    test('fromJson expands tasks', () {
      final json = <String, dynamic>{
        'id': '1',
        'name': 'Group',
        'tasks': [
          {
            'id': 't1',
            'title': 'A',
            'description': 'B',
            'isCompleted': false,
            'priority': 'LOW',
            'ownerId': 'user',
          },
        ],
      };

      final response = TaskGroupResponse.fromJson(json);

      expect(response.tasks, hasLength(1));
      expect(response.tasks.first.title, 'A');
    });

    test('toJson serializes tasks', () {
      final response = TaskGroupResponse.fromJson({
        'id': '1',
        'name': 'Group',
        'tasks': [
          {
            'id': 't1',
            'title': 'A',
            'description': 'B',
            'isCompleted': false,
            'priority': 'LOW',
            'ownerId': 'user',
          },
        ],
      });

      final json = response.toJson();

      expect(json['tasks'], isA<List<dynamic>>());
      expect((json['tasks'] as List<dynamic>).length, 1);
    });
  });
}
