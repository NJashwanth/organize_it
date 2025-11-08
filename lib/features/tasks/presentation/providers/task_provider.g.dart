// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'task_provider.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning

@ProviderFor(taskRepository)
const taskRepositoryProvider = TaskRepositoryProvider._();

final class TaskRepositoryProvider
    extends $FunctionalProvider<TaskRepository, TaskRepository, TaskRepository>
    with $Provider<TaskRepository> {
  const TaskRepositoryProvider._()
      : super(
          from: null,
          argument: null,
          retry: null,
          name: r'taskRepositoryProvider',
          isAutoDispose: true,
          dependencies: null,
          $allTransitiveDependencies: null,
        );

  @override
  String debugGetCreateSourceHash() => _$taskRepositoryHash();

  @$internal
  @override
  $ProviderElement<TaskRepository> $createElement($ProviderPointer pointer) =>
      $ProviderElement(pointer);

  @override
  TaskRepository create(Ref ref) {
    return taskRepository(ref);
  }

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(TaskRepository value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<TaskRepository>(value),
    );
  }
}

String _$taskRepositoryHash() => r'c37d339a0e4aa4f70fce2c08e907a8819818da53';

@ProviderFor(Tasks)
const tasksProvider = TasksProvider._();

final class TasksProvider
    extends $NotifierProvider<Tasks, AsyncValue<List<TaskEntity>>> {
  const TasksProvider._()
      : super(
          from: null,
          argument: null,
          retry: null,
          name: r'tasksProvider',
          isAutoDispose: true,
          dependencies: null,
          $allTransitiveDependencies: null,
        );

  @override
  String debugGetCreateSourceHash() => _$tasksHash();

  @$internal
  @override
  Tasks create() => Tasks();

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(AsyncValue<List<TaskEntity>> value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<AsyncValue<List<TaskEntity>>>(value),
    );
  }
}

String _$tasksHash() => r'8f93d27573ab002f5e35b63ea64c6549ffa78fc8';

abstract class _$Tasks extends $Notifier<AsyncValue<List<TaskEntity>>> {
  AsyncValue<List<TaskEntity>> build();
  @$mustCallSuper
  @override
  void runBuild() {
    final created = build();
    final ref = this.ref
        as $Ref<AsyncValue<List<TaskEntity>>, AsyncValue<List<TaskEntity>>>;
    final element = ref.element as $ClassProviderElement<
        AnyNotifier<AsyncValue<List<TaskEntity>>, AsyncValue<List<TaskEntity>>>,
        AsyncValue<List<TaskEntity>>,
        Object?,
        Object?>;
    element.handleValue(ref, created);
  }
}
