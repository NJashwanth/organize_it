// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'task_group_response_model.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$TaskGroupResponseModel {

 String get id; String get name; String? get description; DateTime? get createdAt; DateTime? get updatedAt; List<TaskModel> get tasks;
/// Create a copy of TaskGroupResponseModel
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$TaskGroupResponseModelCopyWith<TaskGroupResponseModel> get copyWith => _$TaskGroupResponseModelCopyWithImpl<TaskGroupResponseModel>(this as TaskGroupResponseModel, _$identity);

  /// Serializes this TaskGroupResponseModel to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is TaskGroupResponseModel&&(identical(other.id, id) || other.id == id)&&(identical(other.name, name) || other.name == name)&&(identical(other.description, description) || other.description == description)&&(identical(other.createdAt, createdAt) || other.createdAt == createdAt)&&(identical(other.updatedAt, updatedAt) || other.updatedAt == updatedAt)&&const DeepCollectionEquality().equals(other.tasks, tasks));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,id,name,description,createdAt,updatedAt,const DeepCollectionEquality().hash(tasks));

@override
String toString() {
  return 'TaskGroupResponseModel(id: $id, name: $name, description: $description, createdAt: $createdAt, updatedAt: $updatedAt, tasks: $tasks)';
}


}

/// @nodoc
abstract mixin class $TaskGroupResponseModelCopyWith<$Res>  {
  factory $TaskGroupResponseModelCopyWith(TaskGroupResponseModel value, $Res Function(TaskGroupResponseModel) _then) = _$TaskGroupResponseModelCopyWithImpl;
@useResult
$Res call({
 String id, String name, String? description, DateTime? createdAt, DateTime? updatedAt, List<TaskModel> tasks
});




}
/// @nodoc
class _$TaskGroupResponseModelCopyWithImpl<$Res>
    implements $TaskGroupResponseModelCopyWith<$Res> {
  _$TaskGroupResponseModelCopyWithImpl(this._self, this._then);

  final TaskGroupResponseModel _self;
  final $Res Function(TaskGroupResponseModel) _then;

/// Create a copy of TaskGroupResponseModel
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? id = null,Object? name = null,Object? description = freezed,Object? createdAt = freezed,Object? updatedAt = freezed,Object? tasks = null,}) {
  return _then(_self.copyWith(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String,name: null == name ? _self.name : name // ignore: cast_nullable_to_non_nullable
as String,description: freezed == description ? _self.description : description // ignore: cast_nullable_to_non_nullable
as String?,createdAt: freezed == createdAt ? _self.createdAt : createdAt // ignore: cast_nullable_to_non_nullable
as DateTime?,updatedAt: freezed == updatedAt ? _self.updatedAt : updatedAt // ignore: cast_nullable_to_non_nullable
as DateTime?,tasks: null == tasks ? _self.tasks : tasks // ignore: cast_nullable_to_non_nullable
as List<TaskModel>,
  ));
}

}


/// Adds pattern-matching-related methods to [TaskGroupResponseModel].
extension TaskGroupResponseModelPatterns on TaskGroupResponseModel {
/// A variant of `map` that fallback to returning `orElse`.
///
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case final Subclass value:
///     return ...;
///   case _:
///     return orElse();
/// }
/// ```

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _TaskGroupResponseModel value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _TaskGroupResponseModel() when $default != null:
return $default(_that);case _:
  return orElse();

}
}
/// A `switch`-like method, using callbacks.
///
/// Callbacks receives the raw object, upcasted.
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case final Subclass value:
///     return ...;
///   case final Subclass2 value:
///     return ...;
/// }
/// ```

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _TaskGroupResponseModel value)  $default,){
final _that = this;
switch (_that) {
case _TaskGroupResponseModel():
return $default(_that);case _:
  throw StateError('Unexpected subclass');

}
}
/// A variant of `map` that fallback to returning `null`.
///
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case final Subclass value:
///     return ...;
///   case _:
///     return null;
/// }
/// ```

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _TaskGroupResponseModel value)?  $default,){
final _that = this;
switch (_that) {
case _TaskGroupResponseModel() when $default != null:
return $default(_that);case _:
  return null;

}
}
/// A variant of `when` that fallback to an `orElse` callback.
///
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case Subclass(:final field):
///     return ...;
///   case _:
///     return orElse();
/// }
/// ```

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( String id,  String name,  String? description,  DateTime? createdAt,  DateTime? updatedAt,  List<TaskModel> tasks)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _TaskGroupResponseModel() when $default != null:
return $default(_that.id,_that.name,_that.description,_that.createdAt,_that.updatedAt,_that.tasks);case _:
  return orElse();

}
}
/// A `switch`-like method, using callbacks.
///
/// As opposed to `map`, this offers destructuring.
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case Subclass(:final field):
///     return ...;
///   case Subclass2(:final field2):
///     return ...;
/// }
/// ```

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( String id,  String name,  String? description,  DateTime? createdAt,  DateTime? updatedAt,  List<TaskModel> tasks)  $default,) {final _that = this;
switch (_that) {
case _TaskGroupResponseModel():
return $default(_that.id,_that.name,_that.description,_that.createdAt,_that.updatedAt,_that.tasks);case _:
  throw StateError('Unexpected subclass');

}
}
/// A variant of `when` that fallback to returning `null`
///
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case Subclass(:final field):
///     return ...;
///   case _:
///     return null;
/// }
/// ```

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( String id,  String name,  String? description,  DateTime? createdAt,  DateTime? updatedAt,  List<TaskModel> tasks)?  $default,) {final _that = this;
switch (_that) {
case _TaskGroupResponseModel() when $default != null:
return $default(_that.id,_that.name,_that.description,_that.createdAt,_that.updatedAt,_that.tasks);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _TaskGroupResponseModel implements TaskGroupResponseModel {
  const _TaskGroupResponseModel({required this.id, required this.name, this.description, this.createdAt, this.updatedAt, final  List<TaskModel> tasks = const <TaskModel>[]}): _tasks = tasks;
  factory _TaskGroupResponseModel.fromJson(Map<String, dynamic> json) => _$TaskGroupResponseModelFromJson(json);

@override final  String id;
@override final  String name;
@override final  String? description;
@override final  DateTime? createdAt;
@override final  DateTime? updatedAt;
 final  List<TaskModel> _tasks;
@override@JsonKey() List<TaskModel> get tasks {
  if (_tasks is EqualUnmodifiableListView) return _tasks;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_tasks);
}


/// Create a copy of TaskGroupResponseModel
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$TaskGroupResponseModelCopyWith<_TaskGroupResponseModel> get copyWith => __$TaskGroupResponseModelCopyWithImpl<_TaskGroupResponseModel>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$TaskGroupResponseModelToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _TaskGroupResponseModel&&(identical(other.id, id) || other.id == id)&&(identical(other.name, name) || other.name == name)&&(identical(other.description, description) || other.description == description)&&(identical(other.createdAt, createdAt) || other.createdAt == createdAt)&&(identical(other.updatedAt, updatedAt) || other.updatedAt == updatedAt)&&const DeepCollectionEquality().equals(other._tasks, _tasks));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,id,name,description,createdAt,updatedAt,const DeepCollectionEquality().hash(_tasks));

@override
String toString() {
  return 'TaskGroupResponseModel(id: $id, name: $name, description: $description, createdAt: $createdAt, updatedAt: $updatedAt, tasks: $tasks)';
}


}

/// @nodoc
abstract mixin class _$TaskGroupResponseModelCopyWith<$Res> implements $TaskGroupResponseModelCopyWith<$Res> {
  factory _$TaskGroupResponseModelCopyWith(_TaskGroupResponseModel value, $Res Function(_TaskGroupResponseModel) _then) = __$TaskGroupResponseModelCopyWithImpl;
@override @useResult
$Res call({
 String id, String name, String? description, DateTime? createdAt, DateTime? updatedAt, List<TaskModel> tasks
});




}
/// @nodoc
class __$TaskGroupResponseModelCopyWithImpl<$Res>
    implements _$TaskGroupResponseModelCopyWith<$Res> {
  __$TaskGroupResponseModelCopyWithImpl(this._self, this._then);

  final _TaskGroupResponseModel _self;
  final $Res Function(_TaskGroupResponseModel) _then;

/// Create a copy of TaskGroupResponseModel
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? id = null,Object? name = null,Object? description = freezed,Object? createdAt = freezed,Object? updatedAt = freezed,Object? tasks = null,}) {
  return _then(_TaskGroupResponseModel(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String,name: null == name ? _self.name : name // ignore: cast_nullable_to_non_nullable
as String,description: freezed == description ? _self.description : description // ignore: cast_nullable_to_non_nullable
as String?,createdAt: freezed == createdAt ? _self.createdAt : createdAt // ignore: cast_nullable_to_non_nullable
as DateTime?,updatedAt: freezed == updatedAt ? _self.updatedAt : updatedAt // ignore: cast_nullable_to_non_nullable
as DateTime?,tasks: null == tasks ? _self._tasks : tasks // ignore: cast_nullable_to_non_nullable
as List<TaskModel>,
  ));
}


}

// dart format on
