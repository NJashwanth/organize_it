// Integration tests for DioService against a live FlutterMockServer.
//
// Each group gets its own server instance so tests are fully isolated.
// These tests exercise every mock-server feature:
//   - CRUD store actions (list, get, create, update, delete)
//   - Query filtering, sorting, and pagination
//   - Static response with template bindings ({{uuid}}, {{request.body.X}})
//   - Custom response headers
//   - Probabilistic error injection (rate: 1.0 → always fires)
//   - Artificial response delay (delay_ms)
import 'package:flutter_test/flutter_test.dart';
import 'package:organize_it/services/dio_service.dart';

import '../helpers/mock_server_helper.dart';

void main() {
  group('DioService – /health', () {
    late MockServerHandle handle;
    late DioService dio;

    setUp(() async {
      handle = await startTasksMockServer();
      dio = DioService(baseUrl: handle.baseUrl);
    });
    tearDown(() => handle.stop());

    test('returns 200 with body and custom header', () async {
      final r = await dio.getRequest('/health');

      expect(r.statusCode, 200);
      expect(r.data['status'], 'ok');
      expect(r.data['version'], '1.0.0');
      expect(r.data['environment'], 'development');
      // Custom header set via the `headers` field in mock.yaml.
      expect(r.headers.value('x-server'), 'flutter-mock-server');
    });
  });

  group('DioService – /session (static + template bindings)', () {
    late MockServerHandle handle;
    late DioService dio;

    setUp(() async {
      handle = await startTasksMockServer();
      dio = DioService(baseUrl: handle.baseUrl);
    });
    tearDown(() => handle.stop());

    test('returns 201 with token, userId, and echoed email', () async {
      final r = await dio.postRequest(
        '/session',
        data: {'email': 'dev@example.com'},
      );

      expect(r.statusCode, 201);
      expect(r.data['token'], isA<String>());
      expect((r.data['token'] as String).isNotEmpty, isTrue);
      expect(r.data['userId'], isA<String>());
      // Template binding: {{request.body.email}} echoes back the posted email.
      expect(r.data['email'], 'dev@example.com');
      expect(r.data['message'], 'Signed in');
    });
  });

  group('DioService – GET /tasks (list, filter, sort, paginate)', () {
    late MockServerHandle handle;
    late DioService dio;

    setUp(() async {
      handle = await startTasksMockServer();
      dio = DioService(baseUrl: handle.baseUrl);
    });
    tearDown(() => handle.stop());

    test('returns all 12 seeded tasks', () async {
      final r = await dio.getRequest('/tasks');

      expect(r.statusCode, 200);
      expect((r.data as List).length, 12);
    });

    test('filters by priority (exact-match query param)', () async {
      final r = await dio.getRequest(
        '/tasks',
        queryParameters: {'priority': 'HIGH'},
      );
      final tasks = r.data as List;

      expect(
        tasks.every((t) => (t as Map<String, dynamic>)['priority'] == 'HIGH'),
        isTrue,
      );
    });

    test('filters by isCompleted', () async {
      final r = await dio.getRequest(
        '/tasks',
        queryParameters: {'isCompleted': 'true'},
      );
      final tasks = r.data as List;

      expect(
        tasks.every((t) => (t as Map<String, dynamic>)['isCompleted'] == true),
        isTrue,
      );
    });

    test('sorts by title ascending', () async {
      final r = await dio.getRequest(
        '/tasks',
        queryParameters: {'sort': 'title', 'order': 'asc'},
      );
      final titles = (r.data as List)
          .map((t) => (t as Map<String, dynamic>)['title'] as String)
          .toList();
      final sorted = List<String>.from(titles)..sort();

      expect(titles, sorted);
    });

    test('sorts by title descending', () async {
      final r = await dio.getRequest(
        '/tasks',
        queryParameters: {'sort': 'title', 'order': 'desc'},
      );
      final titles = (r.data as List)
          .map((t) => (t as Map<String, dynamic>)['title'] as String)
          .toList();
      final reversed = List<String>.from(titles)
        ..sort((a, b) => b.compareTo(a));

      expect(titles, reversed);
    });

    test('paginates: page 1 and page 2 have distinct records', () async {
      final page1 = await dio.getRequest(
        '/tasks',
        queryParameters: {'limit': '5', 'page': '1'},
      );
      final page2 = await dio.getRequest(
        '/tasks',
        queryParameters: {'limit': '5', 'page': '2'},
      );

      expect((page1.data as List).length, 5);
      expect((page2.data as List).length, 5);

      final ids1 = (page1.data as List).map((t) => t['id'] as String).toSet();
      final ids2 = (page2.data as List).map((t) => t['id'] as String).toSet();
      expect(ids1.intersection(ids2), isEmpty);
    });

    test('page beyond range returns empty list', () async {
      final r = await dio.getRequest(
        '/tasks',
        queryParameters: {'limit': '5', 'page': '99'},
      );

      expect(r.data, isEmpty);
    });
  });

  group('DioService – CRUD /tasks/:id', () {
    late MockServerHandle handle;
    late DioService dio;

    setUp(() async {
      handle = await startTasksMockServer();
      dio = DioService(baseUrl: handle.baseUrl);
    });
    tearDown(() => handle.stop());

    test('GET returns the seeded task by id', () async {
      final all = await dio.getRequest('/tasks');
      final id = (all.data as List).first['id'] as String;

      final r = await dio.getRequest('/tasks/$id');

      expect(r.statusCode, 200);
      expect(r.data['id'], id);
    });

    test('POST creates a task and GET confirms the persisted record', () async {
      final created = await dio.postRequest(
        '/tasks',
        data: {
          'title': 'Integration Task',
          'description': 'Created by DioService integration test',
          'isCompleted': false,
          'priority': 'LOW',
          'ownerId': 'owner-test-001',
        },
      );

      expect(created.statusCode, 201);
      final id = created.data['id'] as String;
      expect(id.isNotEmpty, isTrue);
      expect(created.data['title'], 'Integration Task');

      final fetched = await dio.getRequest('/tasks/$id');
      expect(fetched.statusCode, 200);
      expect(fetched.data['title'], 'Integration Task');
      expect(fetched.data['priority'], 'LOW');
    });

    test('PUT updates the target record in-place', () async {
      final all = await dio.getRequest('/tasks');
      final id = (all.data as List).first['id'] as String;

      final updated = await dio.putRequest(
        '/tasks/$id',
        data: {'title': 'Updated via PUT', 'isCompleted': true},
      );

      expect(updated.statusCode, 200);
      expect(updated.data['title'], 'Updated via PUT');
      expect(updated.data['isCompleted'], isTrue);

      // Confirm the change is persisted.
      final refetched = await dio.getRequest('/tasks/$id');
      expect(refetched.data['title'], 'Updated via PUT');
    });

    test('DELETE removes the record and returns deleted:true', () async {
      // Create a fresh task so we do not disturb seeded records used by
      // other tests in this group.
      final created = await dio.postRequest(
        '/tasks',
        data: {
          'title': 'To Be Deleted',
          'description': 'Ephemeral',
          'isCompleted': false,
          'priority': 'LOW',
          'ownerId': 'owner-test-002',
        },
      );
      final id = created.data['id'] as String;

      final deleted = await dio.deleteRequest('/tasks/$id');

      expect(deleted.statusCode, 200);
      expect(deleted.data['deleted'], isTrue);
    });

    test(
      'GET non-existent task throws Exception (404 → DioException wrapped)',
      () async {
        expect(
          () => dio.getRequest('/tasks/this-id-does-not-exist'),
          throwsA(isA<Exception>()),
        );
      },
    );
  });

  group('DioService – /task-groups CRUD', () {
    late MockServerHandle handle;
    late DioService dio;

    setUp(() async {
      handle = await startTasksMockServer();
      dio = DioService(baseUrl: handle.baseUrl);
    });
    tearDown(() => handle.stop());

    test('GET returns all 5 seeded groups', () async {
      final r = await dio.getRequest('/task-groups');

      expect(r.statusCode, 200);
      expect((r.data as List).length, 5);
    });

    test('filters groups by isActive', () async {
      final r = await dio.getRequest(
        '/task-groups',
        queryParameters: {'isActive': 'true'},
      );
      final groups = r.data as List;

      expect(
        groups.every((g) => (g as Map<String, dynamic>)['isActive'] == true),
        isTrue,
      );
    });

    test('POST creates a group with generated id', () async {
      final r = await dio.postRequest(
        '/task-groups',
        data: {
          'name': 'Work',
          'description': 'All work-related tasks',
          'ownerId': 'owner-test-003',
          'isActive': true,
        },
      );

      expect(r.statusCode, 201);
      expect(r.data['name'], 'Work');
      expect((r.data['id'] as String).isNotEmpty, isTrue);
    });

    test('PUT updates a group field', () async {
      final all = await dio.getRequest('/task-groups');
      final id = (all.data as List).first['id'] as String;

      final updated = await dio.putRequest(
        '/task-groups/$id',
        data: {'name': 'Renamed Group', 'isActive': false},
      );

      expect(updated.statusCode, 200);
      expect(updated.data['name'], 'Renamed Group');
      expect(updated.data['isActive'], isFalse);
    });

    test('DELETE removes the group', () async {
      final created = await dio.postRequest(
        '/task-groups',
        data: {
          'name': 'Temp Group',
          'description': 'Will be deleted',
          'ownerId': 'owner-test-004',
          'isActive': true,
        },
      );
      final id = created.data['id'] as String;

      final deleted = await dio.deleteRequest('/task-groups/$id');

      expect(deleted.statusCode, 200);
      expect(deleted.data['deleted'], isTrue);
    });
  });

  group('DioService – error injection (rate: 1.0)', () {
    late MockServerHandle handle;
    late DioService dio;

    setUp(() async {
      handle = await startTasksMockServer();
      dio = DioService(baseUrl: handle.baseUrl);
    });
    tearDown(() => handle.stop());

    test('/test/always-error always returns 503 '
        'and DioService wraps it as Exception', () async {
      await expectLater(
        dio.getRequest('/test/always-error'),
        throwsA(isA<Exception>()),
      );
    });
  });

  group('DioService – response delay (delay_ms)', () {
    late MockServerHandle handle;
    late DioService dio;

    setUp(() async {
      handle = await startTasksMockServer();
      dio = DioService(baseUrl: handle.baseUrl);
    });
    tearDown(() => handle.stop());

    test(
      '/test/delayed returns correct body after the configured delay',
      () async {
        final watch = Stopwatch()..start();
        final r = await dio.getRequest('/test/delayed');
        watch.stop();

        expect(r.statusCode, 200);
        expect(r.data['ok'], isTrue);
        // The mock is configured with delay_ms: 50.  Verify at least some delay
        // was applied; use a generous lower bound to avoid flakiness on CI.
        expect(watch.elapsedMilliseconds, greaterThanOrEqualTo(40));
      },
    );
  });
}
