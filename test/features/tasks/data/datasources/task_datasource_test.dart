import 'package:dio/dio.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:organize_it/features/tasks/data/datasources/task_datasource.dart';
import 'package:organize_it/features/tasks/domain/entities/task.dart';
import 'package:organize_it/services/dio_service.dart';

class _MockDioService extends Mock implements DioService {}

void main() {
  group('TaskDatasource', () {
    late _MockDioService dioService;
    late TaskDatasource datasource;

    setUp(() {
      dioService = _MockDioService();
      datasource = TaskDatasource(dioService: dioService);
    });

    test('getTasks maps response into TaskEntity list', () async {
      when(() => dioService.getRequest('/tasks')).thenAnswer(
        (_) async => Response(
          requestOptions: RequestOptions(path: '/tasks'),
          data: [
            {
              'id': '1',
              'title': 'A',
              'description': 'B',
              'isCompleted': false,
              'priority': 'LOW',
              'ownerId': 'user',
            },
          ],
        ),
      );

      final result = await datasource.getTasks();

      expect(result, isA<List<TaskEntity>>());
      expect(result.single.title, 'A');
    });

    test('getTasksByDate passes query parameters', () async {
      when(
        () => dioService.getRequest(
          '/tasks',
          queryParameters: any(named: 'queryParameters'),
        ),
      ).thenAnswer(
        (_) async => Response(
          requestOptions: RequestOptions(path: '/tasks'),
          data: [],
        ),
      );

      await datasource.getTasksByDate('2025-01-01');

      verify(
        () => dioService.getRequest(
          '/tasks',
          queryParameters: {'date': '2025-01-01'},
        ),
      ).called(1);
    });

    test('addTask sends model payload', () async {
      const task = TaskEntity(
        id: '1',
        title: 'A',
        description: 'B',
        isCompleted: false,
        priority: TaskPriority.low,
        ownerId: 'user',
      );

      when(
        () => dioService.postRequest('/tasks', data: any(named: 'data')),
      ).thenAnswer(
        (_) async => Response(
          requestOptions: RequestOptions(path: '/tasks'),
          data: {},
        ),
      );

      await datasource.addTask(task);

      final captured =
          verify(
                () => dioService.postRequest(
                  '/tasks',
                  data: captureAny(named: 'data'),
                ),
              ).captured.single
              as Map<String, dynamic>;

      expect(captured['title'], 'A');
      expect(captured['priority'], 'LOW');
    });

    test('updateTask merges id into payload', () async {
      when(
        () => dioService.putRequest('/tasks/1', data: any(named: 'data')),
      ).thenAnswer(
        (_) async => Response(
          requestOptions: RequestOptions(path: '/tasks/1'),
          data: {},
        ),
      );

      await datasource.updateTask('1', {'title': 'Updated'});

      final captured =
          verify(
                () => dioService.putRequest(
                  '/tasks/1',
                  data: captureAny(named: 'data'),
                ),
              ).captured.single
              as Map<String, dynamic>;

      expect(captured['id'], '1');
      expect(captured['title'], 'Updated');
    });

    test('deleteTask calls delete endpoint', () async {
      when(() => dioService.deleteRequest('/tasks/1')).thenAnswer(
        (_) async => Response(
          requestOptions: RequestOptions(path: '/tasks/1'),
          data: {},
        ),
      );

      await datasource.deleteTask('1');

      verify(() => dioService.deleteRequest('/tasks/1')).called(1);
    });

    test('getTaskById maps response into entity', () async {
      when(() => dioService.getRequest('/tasks/1')).thenAnswer(
        (_) async => Response(
          requestOptions: RequestOptions(path: '/tasks/1'),
          data: {
            'id': '1',
            'title': 'A',
            'description': 'B',
            'isCompleted': false,
            'priority': 'LOW',
            'ownerId': 'user',
          },
        ),
      );

      final task = await datasource.getTaskById('1');

      expect(task.id, '1');
      expect(task.title, 'A');
    });
  });
}
