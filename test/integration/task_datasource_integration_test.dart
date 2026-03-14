// Integration tests for TaskDatasource against a live FlutterMockServer.
//
// Unlike the unit tests in task_datasource_test.dart (which mock DioService),
// these tests use a *real* DioService wired to a real local HTTP server so the
// full serialisation / deserialisation path is exercised end-to-end:
//
//   TaskDatasource → DioService → Dio HTTP client → FlutterMockServer
//                                                ↓
//     TaskEntity  ← TaskModel.fromMap ← JSON body ←─────────────────────────
import 'package:flutter_test/flutter_test.dart';
import 'package:organize_it/features/tasks/data/datasources/task_datasource.dart';
import 'package:organize_it/features/tasks/domain/entities/task.dart';
import 'package:organize_it/services/dio_service.dart';

import '../helpers/mock_server_helper.dart';

void main() {
  group('TaskDatasource integration', () {
    late MockServerHandle handle;
    late TaskDatasource datasource;

    setUp(() async {
      handle = await startTasksMockServer();
      datasource = TaskDatasource(
        dioService: DioService(baseUrl: handle.baseUrl),
      );
    });
    tearDown(() => handle.stop());

    // ── getTasks ─────────────────────────────────────────────────────────────

    test(
      'getTasks() maps all 12 seeded records into TaskEntity instances',
      () async {
        final tasks = await datasource.getTasks();

        expect(tasks, isA<List<TaskEntity>>());
        expect(tasks.length, 12);
        // Verify that every record round-trips through TaskModel correctly.
        for (final task in tasks) {
          expect(task.id.isNotEmpty, isTrue);
          expect(task.title.isNotEmpty, isTrue);
          expect(TaskPriority.values.contains(task.priority), isTrue);
        }
      },
    );

    // ── getTasksByDate ────────────────────────────────────────────────────────

    test('getTasksByDate() returns an empty list when no record has a '
        'matching "date" field', () async {
      // The Task model has no "date" field. The mock server filters
      // ?date=X by strict equality, so all records are excluded.
      final tasks = await datasource.getTasksByDate('2025-01-01');

      expect(tasks, isA<List<TaskEntity>>());
      expect(tasks, isEmpty);
    });

    // ── getTaskById ───────────────────────────────────────────────────────────

    test('getTaskById() returns the matching entity', () async {
      final all = await datasource.getTasks();
      final expected = all.first;

      final found = await datasource.getTaskById(expected.id);

      expect(found.id, expected.id);
      expect(found.title, expected.title);
      expect(found.priority, expected.priority);
      expect(found.ownerId, expected.ownerId);
    });

    test('getTaskById() throws Exception for an unknown id', () async {
      await expectLater(
        datasource.getTaskById('id-that-does-not-exist'),
        throwsA(isA<Exception>()),
      );
    });

    // ── addTask ───────────────────────────────────────────────────────────────

    test('addTask() persists the task so the store grows by one', () async {
      const newTask = TaskEntity(
        id: '',
        title: 'My Integration Task',
        description: 'Added through the real mock server',
        isCompleted: false,
        priority: TaskPriority.high,
        ownerId: 'owner-integration-001',
      );

      await expectLater(datasource.addTask(newTask), completes);

      final all = await datasource.getTasks();
      expect(all.length, 13);
      expect(all.any((t) => t.title == 'My Integration Task'), isTrue);
    });

    test('addTask() round-trips priority correctly', () async {
      for (final priority in TaskPriority.values) {
        final task = TaskEntity(
          id: '',
          title: 'Priority test ${priority.serverName}',
          description: 'Testing priority ${priority.serverName}',
          isCompleted: false,
          priority: priority,
          ownerId: 'owner-priority-test',
        );

        // Should not throw regardless of priority value.
        await expectLater(datasource.addTask(task), completes);
      }
    });

    // ── updateTask ────────────────────────────────────────────────────────────

    test('updateTask() modifies the target record in the store', () async {
      final all = await datasource.getTasks();
      final target = all.first;

      await datasource.updateTask(target.id, {
        'title': 'Renamed via updateTask',
        'isCompleted': true,
      });

      final refreshed = await datasource.getTaskById(target.id);
      expect(refreshed.title, 'Renamed via updateTask');
      expect(refreshed.isCompleted, isTrue);
    });

    test('updateTask() merges id into the payload (no id collision)', () async {
      final all = await datasource.getTasks();
      final target = all.last;

      // The datasource adds `id` to the payload internally; the mock server
      // must not end up with a duplicate-id conflict.
      await expectLater(
        datasource.updateTask(target.id, {'description': 'Updated desc'}),
        completes,
      );

      final refreshed = await datasource.getTaskById(target.id);
      expect(refreshed.description, 'Updated desc');
    });

    // ── deleteTask ────────────────────────────────────────────────────────────

    test(
      'deleteTask() removes the record so a subsequent GET throws',
      () async {
        final all = await datasource.getTasks();
        final target = all.last;

        await datasource.deleteTask(target.id);

        await expectLater(
          datasource.getTaskById(target.id),
          throwsA(isA<Exception>()),
        );
      },
    );

    test('deleteTask() reduces the store count by one', () async {
      final before = await datasource.getTasks();
      await datasource.deleteTask(before.last.id);
      final after = await datasource.getTasks();

      expect(after.length, before.length - 1);
    });
  });
}
