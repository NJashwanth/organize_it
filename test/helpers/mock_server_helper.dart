import 'dart:io';

import 'package:flutter_mock_server/flutter_mock_server.dart';

/// Holds a running [FlutterMockServer] instance together with its ephemeral
/// port and temporary directory so callers can tear down cleanly.
class MockServerHandle {
  MockServerHandle._({
    required this.server,
    required this.port,
    required Directory tempDir,
  }) : _tempDir = tempDir;

  final FlutterMockServer server;

  /// The ephemeral port the server is listening on.
  final int port;

  final Directory _tempDir;

  /// Convenience base URL ready for use with [DioService].
  String get baseUrl => 'http://127.0.0.1:$port';

  /// Stops the server and removes the temporary YAML config file.
  Future<void> stop() async {
    await server.stop();
    if (await _tempDir.exists()) {
      await _tempDir.delete(recursive: true);
    }
  }
}

/// Starts a [FlutterMockServer] pre-configured with the organize_it task API.
///
/// Uses an ephemeral OS-assigned port so multiple test groups can run in
/// parallel without port collisions.  The YAML content is embedded here so
/// the tests are hermetic — no filesystem path assumptions are needed.
Future<MockServerHandle> startTasksMockServer() async {
  final port = await _freePort();
  final tempDir = await Directory.systemTemp.createTemp('organize_it_mock_');
  final configFile = File('${tempDir.path}/mock.yaml');
  await configFile.writeAsString(_mockYaml());

  final server = FlutterMockServer(
    configPath: configFile.path,
    host: '127.0.0.1',
    port: port,
  );
  await server.start();

  return MockServerHandle._(server: server, port: port, tempDir: tempDir);
}

/// Binds to port 0 to let the OS choose a free port, then releases the socket.
Future<int> _freePort() async {
  final socket = await ServerSocket.bind(InternetAddress.loopbackIPv4, 0);
  final port = socket.port;
  await socket.close();
  return port;
}

/// YAML configuration that mirrors [mock.yaml] at the repo root.
///
/// Features exercised:
///   - [seed]        deterministic generated data across reloads
///   - [models]      uuid, word, sentence, bool, enum, timestamp, array
///   - [stores]      in-memory seeded collections
///   - CRUD actions  list / get / create / update / delete
///   - [headers]     custom response headers
///   - [delay_ms]    artificial latency
///   - [error]       probabilistic error injection
///   - template      {{uuid}}, {{request.body.X}}
String _mockYaml() => r'''
seed: 42

models:
  Task:
    id: uuid
    title: word
    description: sentence
    isCompleted: bool
    priority:
      enum: [HIGH, MEDIUM, LOW]
    ownerId: uuid
    createdAt: timestamp
    updatedAt: timestamp

  TaskGroup:
    id: uuid
    name: word
    description: sentence
    ownerId: uuid
    isActive: bool
    tasksList:
      type: array
      items: uuid
      count: 3
    createdAt: timestamp
    updatedAt: timestamp

stores:
  tasks:
    model: Task
    count: 12

  task_groups:
    model: TaskGroup
    count: 5

routes:
  - path: /tasks
    method: GET
    action: list
    store: tasks

  - path: /tasks/:id
    method: GET
    action: get
    store: tasks

  - path: /tasks
    method: POST
    action: create
    store: tasks

  - path: /tasks/:id
    method: PUT
    action: update
    store: tasks

  - path: /tasks/:id
    method: DELETE
    action: delete
    store: tasks

  - path: /task-groups
    method: GET
    action: list
    store: task_groups

  - path: /task-groups/:id
    method: GET
    action: get
    store: task_groups

  - path: /task-groups
    method: POST
    action: create
    store: task_groups

  - path: /task-groups/:id
    method: PUT
    action: update
    store: task_groups

  - path: /task-groups/:id
    method: DELETE
    action: delete
    store: task_groups

  - path: /session
    method: POST
    response:
      status: 201
      body:
        token: "{{uuid}}"
        userId: "{{uuid}}"
        message: Signed in
        email: "{{request.body.email}}"
      error:
        status: 401
        rate: 0.0
        body:
          message: Unauthorized

  - path: /health
    method: GET
    response:
      status: 200
      headers:
        x-server: flutter-mock-server
      body:
        status: ok
        version: "1.0.0"
        environment: development

  - path: /test/always-error
    method: GET
    response:
      status: 200
      body:
        ok: true
      error:
        status: 503
        rate: 1.0
        body:
          message: Simulated server error

  - path: /test/delayed
    method: GET
    response:
      status: 200
      body:
        ok: true
      delay_ms: 50
''';
