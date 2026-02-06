// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'task_group_model.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$TaskGroupModel {

 String get id; String get name; String? get description; DateTime? get createdAt; DateTime? get updatedAt; List<String> get tasksList; String get ownerId; bool get isActive;
/// Create a copy of TaskGroupModel
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$TaskGroupModelCopyWith<TaskGroupModel> get copyWith => _$TaskGroupModelCopyWithImpl<TaskGroupModel>(this as TaskGroupModel, _$identity);

  /// Serializes this TaskGroupModel to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is TaskGroupModel&&(identical(other.id, id) || other.id == id)&&(identical(other.name, name) || other.name == name)&&(identical(other.description, description) || other.description == description)&&(identical(other.createdAt, createdAt) || other.createdAt == createdAt)&&(identical(other.updatedAt, updatedAt) || other.updatedAt == updatedAt)&&const DeepCollectionEquality().equals(other.tasksList, tasksList)&&(identical(other.ownerId, ownerId) || other.ownerId == ownerId)&&(identical(other.isActive, isActive) || other.isActive == isActive));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,id,name,description,createdAt,updatedAt,const DeepCollectionEquality().hash(tasksList),ownerId,isActive);

@override
String toString() {
  return 'TaskGroupModel(id: $id, name: $name, description: $description, createdAt: $createdAt, updatedAt: $updatedAt, tasksList: $tasksList, ownerId: $ownerId, isActive: $isActive)';
}


}

/// @nodoc
abstract mixin class $TaskGroupModelCopyWith<$Res>  {
  factory $TaskGroupModelCopyWith(TaskGroupModel value, $Res Function(TaskGroupModel) _then) = _$TaskGroupModelCopyWithImpl;
@useResult
$Res call({
 String id, String name, String? description, DateTime? createdAt, DateTime? updatedAt, List<String> tasksList, String ownerId, bool isActive
});




}
/// @nodoc
class _$TaskGroupModelCopyWithImpl<$Res>
    implements $TaskGroupModelCopyWith<$Res> {
  _$TaskGroupModelCopyWithImpl(this._self, this._then);

  final TaskGroupModel _self;
  final $Res Function(TaskGroupModel) _then;

/// Create a copy of TaskGroupModel
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? id = null,Object? name = null,Object? description = freezed,Object? createdAt = freezed,Object? updatedAt = freezed,Object? tasksList = null,Object? ownerId = null,Object? isActive = null,}) {
  return _then(_self.copyWith(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String,name: null == name ? _self.name : name // ignore: cast_nullable_to_non_nullable
as String,description: freezed == description ? _self.description : description // ignore: cast_nullable_to_non_nullable
as String?,createdAt: freezed == createdAt ? _self.createdAt : createdAt // ignore: cast_nullable_to_non_nullable
as DateTime?,updatedAt: freezed == updatedAt ? _self.updatedAt : updatedAt // ignore: cast_nullable_to_non_nullable
as DateTime?,tasksList: null == tasksList ? _self.tasksList : tasksList // ignore: cast_nullable_to_non_nullable
as List<String>,ownerId: null == ownerId ? _self.ownerId : ownerId // ignore: cast_nullable_to_non_nullable
as String,isActive: null == isActive ? _self.isActive : isActive // ignore: cast_nullable_to_non_nullable
as bool,
  ));
}

}


/// Adds pattern-matching-related methods to [TaskGroupModel].
extension TaskGroupModelPatterns on TaskGroupModel {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _TaskGroupModel value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _TaskGroupModel() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _TaskGroupModel value)  $default,){
final _that = this;
switch (_that) {
case _TaskGroupModel():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _TaskGroupModel value)?  $default,){
final _that = this;
switch (_that) {
case _TaskGroupModel() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( String id,  String name,  String? description,  DateTime? createdAt,  DateTime? updatedAt,  List<String> tasksList,  String ownerId,  bool isActive)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _TaskGroupModel() when $default != null:
return $default(_that.id,_that.name,_that.description,_that.createdAt,_that.updatedAt,_that.tasksList,_that.ownerId,_that.isActive);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( String id,  String name,  String? description,  DateTime? createdAt,  DateTime? updatedAt,  List<String> tasksList,  String ownerId,  bool isActive)  $default,) {final _that = this;
switch (_that) {
case _TaskGroupModel():
return $default(_that.id,_that.name,_that.description,_that.createdAt,_that.updatedAt,_that.tasksList,_that.ownerId,_that.isActive);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( String id,  String name,  String? description,  DateTime? createdAt,  DateTime? updatedAt,  List<String> tasksList,  String ownerId,  bool isActive)?  $default,) {final _that = this;
switch (_that) {
case _TaskGroupModel() when $default != null:
return $default(_that.id,_that.name,_that.description,_that.createdAt,_that.updatedAt,_that.tasksList,_that.ownerId,_that.isActive);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _TaskGroupModel implements TaskGroupModel {
  const _TaskGroupModel({required this.id, required this.name, this.description, this.createdAt, this.updatedAt, final  List<String> tasksList = const <String>[], required this.ownerId, this.isActive = true}): _tasksList = tasksList;
  factory _TaskGroupModel.fromJson(Map<String, dynamic> json) => _$TaskGroupModelFromJson(json);

@override final  String id;
@override final  String name;
@override final  String? description;
@override final  DateTime? createdAt;
@override final  DateTime? updatedAt;
 final  List<String> _tasksList;
@override@JsonKey() List<String> get tasksList {
  if (_tasksList is EqualUnmodifiableListView) return _tasksList;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_tasksList);
}

@override final  String ownerId;
@override@JsonKey() final  bool isActive;

/// Create a copy of TaskGroupModel
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$TaskGroupModelCopyWith<_TaskGroupModel> get copyWith => __$TaskGroupModelCopyWithImpl<_TaskGroupModel>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$TaskGroupModelToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _TaskGroupModel&&(identical(other.id, id) || other.id == id)&&(identical(other.name, name) || other.name == name)&&(identical(other.description, description) || other.description == description)&&(identical(other.createdAt, createdAt) || other.createdAt == createdAt)&&(identical(other.updatedAt, updatedAt) || other.updatedAt == updatedAt)&&const DeepCollectionEquality().equals(other._tasksList, _tasksList)&&(identical(other.ownerId, ownerId) || other.ownerId == ownerId)&&(identical(other.isActive, isActive) || other.isActive == isActive));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,id,name,description,createdAt,updatedAt,const DeepCollectionEquality().hash(_tasksList),ownerId,isActive);

@override
String toString() {
  return 'TaskGroupModel(id: $id, name: $name, description: $description, createdAt: $createdAt, updatedAt: $updatedAt, tasksList: $tasksList, ownerId: $ownerId, isActive: $isActive)';
}


}

/// @nodoc
abstract mixin class _$TaskGroupModelCopyWith<$Res> implements $TaskGroupModelCopyWith<$Res> {
  factory _$TaskGroupModelCopyWith(_TaskGroupModel value, $Res Function(_TaskGroupModel) _then) = __$TaskGroupModelCopyWithImpl;
@override @useResult
$Res call({
 String id, String name, String? description, DateTime? createdAt, DateTime? updatedAt, List<String> tasksList, String ownerId, bool isActive
});




}
/// @nodoc
class __$TaskGroupModelCopyWithImpl<$Res>
    implements _$TaskGroupModelCopyWith<$Res> {
  __$TaskGroupModelCopyWithImpl(this._self, this._then);

  final _TaskGroupModel _self;
  final $Res Function(_TaskGroupModel) _then;

/// Create a copy of TaskGroupModel
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? id = null,Object? name = null,Object? description = freezed,Object? createdAt = freezed,Object? updatedAt = freezed,Object? tasksList = null,Object? ownerId = null,Object? isActive = null,}) {
  return _then(_TaskGroupModel(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String,name: null == name ? _self.name : name // ignore: cast_nullable_to_non_nullable
as String,description: freezed == description ? _self.description : description // ignore: cast_nullable_to_non_nullable
as String?,createdAt: freezed == createdAt ? _self.createdAt : createdAt // ignore: cast_nullable_to_non_nullable
as DateTime?,updatedAt: freezed == updatedAt ? _self.updatedAt : updatedAt // ignore: cast_nullable_to_non_nullable
as DateTime?,tasksList: null == tasksList ? _self._tasksList : tasksList // ignore: cast_nullable_to_non_nullable
as List<String>,ownerId: null == ownerId ? _self.ownerId : ownerId // ignore: cast_nullable_to_non_nullable
as String,isActive: null == isActive ? _self.isActive : isActive // ignore: cast_nullable_to_non_nullable
as bool,
  ));
}


}

// dart format on
