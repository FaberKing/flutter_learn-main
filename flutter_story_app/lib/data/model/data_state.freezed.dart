// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'data_state.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#custom-getters-and-methods');

/// @nodoc
mixin _$DataState<T> {
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function() loading,
    required TResult Function(List<T> data) loaded,
    required TResult Function(Object? e, StackTrace? stack) error,
    required TResult Function(List<T> data) onGoingLoading,
    required TResult Function(List<T> data, Object? e, StackTrace? stack)
        onGoingError,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function()? loading,
    TResult? Function(List<T> data)? loaded,
    TResult? Function(Object? e, StackTrace? stack)? error,
    TResult? Function(List<T> data)? onGoingLoading,
    TResult? Function(List<T> data, Object? e, StackTrace? stack)? onGoingError,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function()? loading,
    TResult Function(List<T> data)? loaded,
    TResult Function(Object? e, StackTrace? stack)? error,
    TResult Function(List<T> data)? onGoingLoading,
    TResult Function(List<T> data, Object? e, StackTrace? stack)? onGoingError,
    required TResult orElse(),
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(DataStateLoading<T> value) loading,
    required TResult Function(DataStateLoaded<T> value) loaded,
    required TResult Function(DataStateError<T> value) error,
    required TResult Function(OnGoingLoading<T> value) onGoingLoading,
    required TResult Function(OnGoingError<T> value) onGoingError,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(DataStateLoading<T> value)? loading,
    TResult? Function(DataStateLoaded<T> value)? loaded,
    TResult? Function(DataStateError<T> value)? error,
    TResult? Function(OnGoingLoading<T> value)? onGoingLoading,
    TResult? Function(OnGoingError<T> value)? onGoingError,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(DataStateLoading<T> value)? loading,
    TResult Function(DataStateLoaded<T> value)? loaded,
    TResult Function(DataStateError<T> value)? error,
    TResult Function(OnGoingLoading<T> value)? onGoingLoading,
    TResult Function(OnGoingError<T> value)? onGoingError,
    required TResult orElse(),
  }) =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $DataStateCopyWith<T, $Res> {
  factory $DataStateCopyWith(
          DataState<T> value, $Res Function(DataState<T>) then) =
      _$DataStateCopyWithImpl<T, $Res, DataState<T>>;
}

/// @nodoc
class _$DataStateCopyWithImpl<T, $Res, $Val extends DataState<T>>
    implements $DataStateCopyWith<T, $Res> {
  _$DataStateCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;
}

/// @nodoc
abstract class _$$DataStateLoadingCopyWith<T, $Res> {
  factory _$$DataStateLoadingCopyWith(_$DataStateLoading<T> value,
          $Res Function(_$DataStateLoading<T>) then) =
      __$$DataStateLoadingCopyWithImpl<T, $Res>;
}

/// @nodoc
class __$$DataStateLoadingCopyWithImpl<T, $Res>
    extends _$DataStateCopyWithImpl<T, $Res, _$DataStateLoading<T>>
    implements _$$DataStateLoadingCopyWith<T, $Res> {
  __$$DataStateLoadingCopyWithImpl(
      _$DataStateLoading<T> _value, $Res Function(_$DataStateLoading<T>) _then)
      : super(_value, _then);
}

/// @nodoc

class _$DataStateLoading<T> implements DataStateLoading<T> {
  const _$DataStateLoading();

  @override
  String toString() {
    return 'DataState<$T>.loading()';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType && other is _$DataStateLoading<T>);
  }

  @override
  int get hashCode => runtimeType.hashCode;

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function() loading,
    required TResult Function(List<T> data) loaded,
    required TResult Function(Object? e, StackTrace? stack) error,
    required TResult Function(List<T> data) onGoingLoading,
    required TResult Function(List<T> data, Object? e, StackTrace? stack)
        onGoingError,
  }) {
    return loading();
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function()? loading,
    TResult? Function(List<T> data)? loaded,
    TResult? Function(Object? e, StackTrace? stack)? error,
    TResult? Function(List<T> data)? onGoingLoading,
    TResult? Function(List<T> data, Object? e, StackTrace? stack)? onGoingError,
  }) {
    return loading?.call();
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function()? loading,
    TResult Function(List<T> data)? loaded,
    TResult Function(Object? e, StackTrace? stack)? error,
    TResult Function(List<T> data)? onGoingLoading,
    TResult Function(List<T> data, Object? e, StackTrace? stack)? onGoingError,
    required TResult orElse(),
  }) {
    if (loading != null) {
      return loading();
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(DataStateLoading<T> value) loading,
    required TResult Function(DataStateLoaded<T> value) loaded,
    required TResult Function(DataStateError<T> value) error,
    required TResult Function(OnGoingLoading<T> value) onGoingLoading,
    required TResult Function(OnGoingError<T> value) onGoingError,
  }) {
    return loading(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(DataStateLoading<T> value)? loading,
    TResult? Function(DataStateLoaded<T> value)? loaded,
    TResult? Function(DataStateError<T> value)? error,
    TResult? Function(OnGoingLoading<T> value)? onGoingLoading,
    TResult? Function(OnGoingError<T> value)? onGoingError,
  }) {
    return loading?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(DataStateLoading<T> value)? loading,
    TResult Function(DataStateLoaded<T> value)? loaded,
    TResult Function(DataStateError<T> value)? error,
    TResult Function(OnGoingLoading<T> value)? onGoingLoading,
    TResult Function(OnGoingError<T> value)? onGoingError,
    required TResult orElse(),
  }) {
    if (loading != null) {
      return loading(this);
    }
    return orElse();
  }
}

abstract class DataStateLoading<T> implements DataState<T> {
  const factory DataStateLoading() = _$DataStateLoading<T>;
}

/// @nodoc
abstract class _$$DataStateLoadedCopyWith<T, $Res> {
  factory _$$DataStateLoadedCopyWith(_$DataStateLoaded<T> value,
          $Res Function(_$DataStateLoaded<T>) then) =
      __$$DataStateLoadedCopyWithImpl<T, $Res>;
  @useResult
  $Res call({List<T> data});
}

/// @nodoc
class __$$DataStateLoadedCopyWithImpl<T, $Res>
    extends _$DataStateCopyWithImpl<T, $Res, _$DataStateLoaded<T>>
    implements _$$DataStateLoadedCopyWith<T, $Res> {
  __$$DataStateLoadedCopyWithImpl(
      _$DataStateLoaded<T> _value, $Res Function(_$DataStateLoaded<T>) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? data = null,
  }) {
    return _then(_$DataStateLoaded<T>(
      null == data
          ? _value._data
          : data // ignore: cast_nullable_to_non_nullable
              as List<T>,
    ));
  }
}

/// @nodoc

class _$DataStateLoaded<T> implements DataStateLoaded<T> {
  const _$DataStateLoaded(final List<T> data) : _data = data;

  final List<T> _data;
  @override
  List<T> get data {
    if (_data is EqualUnmodifiableListView) return _data;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_data);
  }

  @override
  String toString() {
    return 'DataState<$T>.loaded(data: $data)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$DataStateLoaded<T> &&
            const DeepCollectionEquality().equals(other._data, _data));
  }

  @override
  int get hashCode =>
      Object.hash(runtimeType, const DeepCollectionEquality().hash(_data));

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$DataStateLoadedCopyWith<T, _$DataStateLoaded<T>> get copyWith =>
      __$$DataStateLoadedCopyWithImpl<T, _$DataStateLoaded<T>>(
          this, _$identity);

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function() loading,
    required TResult Function(List<T> data) loaded,
    required TResult Function(Object? e, StackTrace? stack) error,
    required TResult Function(List<T> data) onGoingLoading,
    required TResult Function(List<T> data, Object? e, StackTrace? stack)
        onGoingError,
  }) {
    return loaded(data);
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function()? loading,
    TResult? Function(List<T> data)? loaded,
    TResult? Function(Object? e, StackTrace? stack)? error,
    TResult? Function(List<T> data)? onGoingLoading,
    TResult? Function(List<T> data, Object? e, StackTrace? stack)? onGoingError,
  }) {
    return loaded?.call(data);
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function()? loading,
    TResult Function(List<T> data)? loaded,
    TResult Function(Object? e, StackTrace? stack)? error,
    TResult Function(List<T> data)? onGoingLoading,
    TResult Function(List<T> data, Object? e, StackTrace? stack)? onGoingError,
    required TResult orElse(),
  }) {
    if (loaded != null) {
      return loaded(data);
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(DataStateLoading<T> value) loading,
    required TResult Function(DataStateLoaded<T> value) loaded,
    required TResult Function(DataStateError<T> value) error,
    required TResult Function(OnGoingLoading<T> value) onGoingLoading,
    required TResult Function(OnGoingError<T> value) onGoingError,
  }) {
    return loaded(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(DataStateLoading<T> value)? loading,
    TResult? Function(DataStateLoaded<T> value)? loaded,
    TResult? Function(DataStateError<T> value)? error,
    TResult? Function(OnGoingLoading<T> value)? onGoingLoading,
    TResult? Function(OnGoingError<T> value)? onGoingError,
  }) {
    return loaded?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(DataStateLoading<T> value)? loading,
    TResult Function(DataStateLoaded<T> value)? loaded,
    TResult Function(DataStateError<T> value)? error,
    TResult Function(OnGoingLoading<T> value)? onGoingLoading,
    TResult Function(OnGoingError<T> value)? onGoingError,
    required TResult orElse(),
  }) {
    if (loaded != null) {
      return loaded(this);
    }
    return orElse();
  }
}

abstract class DataStateLoaded<T> implements DataState<T> {
  const factory DataStateLoaded(final List<T> data) = _$DataStateLoaded<T>;

  List<T> get data;
  @JsonKey(ignore: true)
  _$$DataStateLoadedCopyWith<T, _$DataStateLoaded<T>> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class _$$DataStateErrorCopyWith<T, $Res> {
  factory _$$DataStateErrorCopyWith(
          _$DataStateError<T> value, $Res Function(_$DataStateError<T>) then) =
      __$$DataStateErrorCopyWithImpl<T, $Res>;
  @useResult
  $Res call({Object? e, StackTrace? stack});
}

/// @nodoc
class __$$DataStateErrorCopyWithImpl<T, $Res>
    extends _$DataStateCopyWithImpl<T, $Res, _$DataStateError<T>>
    implements _$$DataStateErrorCopyWith<T, $Res> {
  __$$DataStateErrorCopyWithImpl(
      _$DataStateError<T> _value, $Res Function(_$DataStateError<T>) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? e = freezed,
    Object? stack = freezed,
  }) {
    return _then(_$DataStateError<T>(
      freezed == e ? _value.e : e,
      freezed == stack
          ? _value.stack
          : stack // ignore: cast_nullable_to_non_nullable
              as StackTrace?,
    ));
  }
}

/// @nodoc

class _$DataStateError<T> implements DataStateError<T> {
  const _$DataStateError(this.e, [this.stack]);

  @override
  final Object? e;
  @override
  final StackTrace? stack;

  @override
  String toString() {
    return 'DataState<$T>.error(e: $e, stack: $stack)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$DataStateError<T> &&
            const DeepCollectionEquality().equals(other.e, e) &&
            (identical(other.stack, stack) || other.stack == stack));
  }

  @override
  int get hashCode =>
      Object.hash(runtimeType, const DeepCollectionEquality().hash(e), stack);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$DataStateErrorCopyWith<T, _$DataStateError<T>> get copyWith =>
      __$$DataStateErrorCopyWithImpl<T, _$DataStateError<T>>(this, _$identity);

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function() loading,
    required TResult Function(List<T> data) loaded,
    required TResult Function(Object? e, StackTrace? stack) error,
    required TResult Function(List<T> data) onGoingLoading,
    required TResult Function(List<T> data, Object? e, StackTrace? stack)
        onGoingError,
  }) {
    return error(e, stack);
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function()? loading,
    TResult? Function(List<T> data)? loaded,
    TResult? Function(Object? e, StackTrace? stack)? error,
    TResult? Function(List<T> data)? onGoingLoading,
    TResult? Function(List<T> data, Object? e, StackTrace? stack)? onGoingError,
  }) {
    return error?.call(e, stack);
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function()? loading,
    TResult Function(List<T> data)? loaded,
    TResult Function(Object? e, StackTrace? stack)? error,
    TResult Function(List<T> data)? onGoingLoading,
    TResult Function(List<T> data, Object? e, StackTrace? stack)? onGoingError,
    required TResult orElse(),
  }) {
    if (error != null) {
      return error(e, stack);
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(DataStateLoading<T> value) loading,
    required TResult Function(DataStateLoaded<T> value) loaded,
    required TResult Function(DataStateError<T> value) error,
    required TResult Function(OnGoingLoading<T> value) onGoingLoading,
    required TResult Function(OnGoingError<T> value) onGoingError,
  }) {
    return error(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(DataStateLoading<T> value)? loading,
    TResult? Function(DataStateLoaded<T> value)? loaded,
    TResult? Function(DataStateError<T> value)? error,
    TResult? Function(OnGoingLoading<T> value)? onGoingLoading,
    TResult? Function(OnGoingError<T> value)? onGoingError,
  }) {
    return error?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(DataStateLoading<T> value)? loading,
    TResult Function(DataStateLoaded<T> value)? loaded,
    TResult Function(DataStateError<T> value)? error,
    TResult Function(OnGoingLoading<T> value)? onGoingLoading,
    TResult Function(OnGoingError<T> value)? onGoingError,
    required TResult orElse(),
  }) {
    if (error != null) {
      return error(this);
    }
    return orElse();
  }
}

abstract class DataStateError<T> implements DataState<T> {
  const factory DataStateError(final Object? e, [final StackTrace? stack]) =
      _$DataStateError<T>;

  Object? get e;
  StackTrace? get stack;
  @JsonKey(ignore: true)
  _$$DataStateErrorCopyWith<T, _$DataStateError<T>> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class _$$OnGoingLoadingCopyWith<T, $Res> {
  factory _$$OnGoingLoadingCopyWith(
          _$OnGoingLoading<T> value, $Res Function(_$OnGoingLoading<T>) then) =
      __$$OnGoingLoadingCopyWithImpl<T, $Res>;
  @useResult
  $Res call({List<T> data});
}

/// @nodoc
class __$$OnGoingLoadingCopyWithImpl<T, $Res>
    extends _$DataStateCopyWithImpl<T, $Res, _$OnGoingLoading<T>>
    implements _$$OnGoingLoadingCopyWith<T, $Res> {
  __$$OnGoingLoadingCopyWithImpl(
      _$OnGoingLoading<T> _value, $Res Function(_$OnGoingLoading<T>) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? data = null,
  }) {
    return _then(_$OnGoingLoading<T>(
      null == data
          ? _value._data
          : data // ignore: cast_nullable_to_non_nullable
              as List<T>,
    ));
  }
}

/// @nodoc

class _$OnGoingLoading<T> implements OnGoingLoading<T> {
  const _$OnGoingLoading(final List<T> data) : _data = data;

  final List<T> _data;
  @override
  List<T> get data {
    if (_data is EqualUnmodifiableListView) return _data;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_data);
  }

  @override
  String toString() {
    return 'DataState<$T>.onGoingLoading(data: $data)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$OnGoingLoading<T> &&
            const DeepCollectionEquality().equals(other._data, _data));
  }

  @override
  int get hashCode =>
      Object.hash(runtimeType, const DeepCollectionEquality().hash(_data));

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$OnGoingLoadingCopyWith<T, _$OnGoingLoading<T>> get copyWith =>
      __$$OnGoingLoadingCopyWithImpl<T, _$OnGoingLoading<T>>(this, _$identity);

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function() loading,
    required TResult Function(List<T> data) loaded,
    required TResult Function(Object? e, StackTrace? stack) error,
    required TResult Function(List<T> data) onGoingLoading,
    required TResult Function(List<T> data, Object? e, StackTrace? stack)
        onGoingError,
  }) {
    return onGoingLoading(data);
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function()? loading,
    TResult? Function(List<T> data)? loaded,
    TResult? Function(Object? e, StackTrace? stack)? error,
    TResult? Function(List<T> data)? onGoingLoading,
    TResult? Function(List<T> data, Object? e, StackTrace? stack)? onGoingError,
  }) {
    return onGoingLoading?.call(data);
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function()? loading,
    TResult Function(List<T> data)? loaded,
    TResult Function(Object? e, StackTrace? stack)? error,
    TResult Function(List<T> data)? onGoingLoading,
    TResult Function(List<T> data, Object? e, StackTrace? stack)? onGoingError,
    required TResult orElse(),
  }) {
    if (onGoingLoading != null) {
      return onGoingLoading(data);
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(DataStateLoading<T> value) loading,
    required TResult Function(DataStateLoaded<T> value) loaded,
    required TResult Function(DataStateError<T> value) error,
    required TResult Function(OnGoingLoading<T> value) onGoingLoading,
    required TResult Function(OnGoingError<T> value) onGoingError,
  }) {
    return onGoingLoading(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(DataStateLoading<T> value)? loading,
    TResult? Function(DataStateLoaded<T> value)? loaded,
    TResult? Function(DataStateError<T> value)? error,
    TResult? Function(OnGoingLoading<T> value)? onGoingLoading,
    TResult? Function(OnGoingError<T> value)? onGoingError,
  }) {
    return onGoingLoading?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(DataStateLoading<T> value)? loading,
    TResult Function(DataStateLoaded<T> value)? loaded,
    TResult Function(DataStateError<T> value)? error,
    TResult Function(OnGoingLoading<T> value)? onGoingLoading,
    TResult Function(OnGoingError<T> value)? onGoingError,
    required TResult orElse(),
  }) {
    if (onGoingLoading != null) {
      return onGoingLoading(this);
    }
    return orElse();
  }
}

abstract class OnGoingLoading<T> implements DataState<T> {
  const factory OnGoingLoading(final List<T> data) = _$OnGoingLoading<T>;

  List<T> get data;
  @JsonKey(ignore: true)
  _$$OnGoingLoadingCopyWith<T, _$OnGoingLoading<T>> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class _$$OnGoingErrorCopyWith<T, $Res> {
  factory _$$OnGoingErrorCopyWith(
          _$OnGoingError<T> value, $Res Function(_$OnGoingError<T>) then) =
      __$$OnGoingErrorCopyWithImpl<T, $Res>;
  @useResult
  $Res call({List<T> data, Object? e, StackTrace? stack});
}

/// @nodoc
class __$$OnGoingErrorCopyWithImpl<T, $Res>
    extends _$DataStateCopyWithImpl<T, $Res, _$OnGoingError<T>>
    implements _$$OnGoingErrorCopyWith<T, $Res> {
  __$$OnGoingErrorCopyWithImpl(
      _$OnGoingError<T> _value, $Res Function(_$OnGoingError<T>) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? data = null,
    Object? e = freezed,
    Object? stack = freezed,
  }) {
    return _then(_$OnGoingError<T>(
      null == data
          ? _value._data
          : data // ignore: cast_nullable_to_non_nullable
              as List<T>,
      freezed == e ? _value.e : e,
      freezed == stack
          ? _value.stack
          : stack // ignore: cast_nullable_to_non_nullable
              as StackTrace?,
    ));
  }
}

/// @nodoc

class _$OnGoingError<T> implements OnGoingError<T> {
  const _$OnGoingError(final List<T> data, this.e, [this.stack]) : _data = data;

  final List<T> _data;
  @override
  List<T> get data {
    if (_data is EqualUnmodifiableListView) return _data;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_data);
  }

  @override
  final Object? e;
  @override
  final StackTrace? stack;

  @override
  String toString() {
    return 'DataState<$T>.onGoingError(data: $data, e: $e, stack: $stack)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$OnGoingError<T> &&
            const DeepCollectionEquality().equals(other._data, _data) &&
            const DeepCollectionEquality().equals(other.e, e) &&
            (identical(other.stack, stack) || other.stack == stack));
  }

  @override
  int get hashCode => Object.hash(
      runtimeType,
      const DeepCollectionEquality().hash(_data),
      const DeepCollectionEquality().hash(e),
      stack);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$OnGoingErrorCopyWith<T, _$OnGoingError<T>> get copyWith =>
      __$$OnGoingErrorCopyWithImpl<T, _$OnGoingError<T>>(this, _$identity);

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function() loading,
    required TResult Function(List<T> data) loaded,
    required TResult Function(Object? e, StackTrace? stack) error,
    required TResult Function(List<T> data) onGoingLoading,
    required TResult Function(List<T> data, Object? e, StackTrace? stack)
        onGoingError,
  }) {
    return onGoingError(data, e, stack);
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function()? loading,
    TResult? Function(List<T> data)? loaded,
    TResult? Function(Object? e, StackTrace? stack)? error,
    TResult? Function(List<T> data)? onGoingLoading,
    TResult? Function(List<T> data, Object? e, StackTrace? stack)? onGoingError,
  }) {
    return onGoingError?.call(data, e, stack);
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function()? loading,
    TResult Function(List<T> data)? loaded,
    TResult Function(Object? e, StackTrace? stack)? error,
    TResult Function(List<T> data)? onGoingLoading,
    TResult Function(List<T> data, Object? e, StackTrace? stack)? onGoingError,
    required TResult orElse(),
  }) {
    if (onGoingError != null) {
      return onGoingError(data, e, stack);
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(DataStateLoading<T> value) loading,
    required TResult Function(DataStateLoaded<T> value) loaded,
    required TResult Function(DataStateError<T> value) error,
    required TResult Function(OnGoingLoading<T> value) onGoingLoading,
    required TResult Function(OnGoingError<T> value) onGoingError,
  }) {
    return onGoingError(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(DataStateLoading<T> value)? loading,
    TResult? Function(DataStateLoaded<T> value)? loaded,
    TResult? Function(DataStateError<T> value)? error,
    TResult? Function(OnGoingLoading<T> value)? onGoingLoading,
    TResult? Function(OnGoingError<T> value)? onGoingError,
  }) {
    return onGoingError?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(DataStateLoading<T> value)? loading,
    TResult Function(DataStateLoaded<T> value)? loaded,
    TResult Function(DataStateError<T> value)? error,
    TResult Function(OnGoingLoading<T> value)? onGoingLoading,
    TResult Function(OnGoingError<T> value)? onGoingError,
    required TResult orElse(),
  }) {
    if (onGoingError != null) {
      return onGoingError(this);
    }
    return orElse();
  }
}

abstract class OnGoingError<T> implements DataState<T> {
  const factory OnGoingError(final List<T> data, final Object? e,
      [final StackTrace? stack]) = _$OnGoingError<T>;

  List<T> get data;
  Object? get e;
  StackTrace? get stack;
  @JsonKey(ignore: true)
  _$$OnGoingErrorCopyWith<T, _$OnGoingError<T>> get copyWith =>
      throw _privateConstructorUsedError;
}
