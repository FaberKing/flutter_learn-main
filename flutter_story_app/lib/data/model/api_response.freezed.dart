// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'api_response.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#custom-getters-and-methods');

ApiResponse _$ApiResponseFromJson(Map<String, dynamic> json) {
  return _ApiResponse.fromJson(json);
}

/// @nodoc
mixin _$ApiResponse {
  bool get error => throw _privateConstructorUsedError;
  String get message => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $ApiResponseCopyWith<ApiResponse> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $ApiResponseCopyWith<$Res> {
  factory $ApiResponseCopyWith(
          ApiResponse value, $Res Function(ApiResponse) then) =
      _$ApiResponseCopyWithImpl<$Res, ApiResponse>;
  @useResult
  $Res call({bool error, String message});
}

/// @nodoc
class _$ApiResponseCopyWithImpl<$Res, $Val extends ApiResponse>
    implements $ApiResponseCopyWith<$Res> {
  _$ApiResponseCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? error = null,
    Object? message = null,
  }) {
    return _then(_value.copyWith(
      error: null == error
          ? _value.error
          : error // ignore: cast_nullable_to_non_nullable
              as bool,
      message: null == message
          ? _value.message
          : message // ignore: cast_nullable_to_non_nullable
              as String,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$_ApiResponseCopyWith<$Res>
    implements $ApiResponseCopyWith<$Res> {
  factory _$$_ApiResponseCopyWith(
          _$_ApiResponse value, $Res Function(_$_ApiResponse) then) =
      __$$_ApiResponseCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({bool error, String message});
}

/// @nodoc
class __$$_ApiResponseCopyWithImpl<$Res>
    extends _$ApiResponseCopyWithImpl<$Res, _$_ApiResponse>
    implements _$$_ApiResponseCopyWith<$Res> {
  __$$_ApiResponseCopyWithImpl(
      _$_ApiResponse _value, $Res Function(_$_ApiResponse) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? error = null,
    Object? message = null,
  }) {
    return _then(_$_ApiResponse(
      error: null == error
          ? _value.error
          : error // ignore: cast_nullable_to_non_nullable
              as bool,
      message: null == message
          ? _value.message
          : message // ignore: cast_nullable_to_non_nullable
              as String,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$_ApiResponse with DiagnosticableTreeMixin implements _ApiResponse {
  const _$_ApiResponse({required this.error, required this.message});

  factory _$_ApiResponse.fromJson(Map<String, dynamic> json) =>
      _$$_ApiResponseFromJson(json);

  @override
  final bool error;
  @override
  final String message;

  @override
  String toString({DiagnosticLevel minLevel = DiagnosticLevel.info}) {
    return 'ApiResponse(error: $error, message: $message)';
  }

  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    super.debugFillProperties(properties);
    properties
      ..add(DiagnosticsProperty('type', 'ApiResponse'))
      ..add(DiagnosticsProperty('error', error))
      ..add(DiagnosticsProperty('message', message));
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$_ApiResponse &&
            (identical(other.error, error) || other.error == error) &&
            (identical(other.message, message) || other.message == message));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode => Object.hash(runtimeType, error, message);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$_ApiResponseCopyWith<_$_ApiResponse> get copyWith =>
      __$$_ApiResponseCopyWithImpl<_$_ApiResponse>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$_ApiResponseToJson(
      this,
    );
  }
}

abstract class _ApiResponse implements ApiResponse {
  const factory _ApiResponse(
      {required final bool error,
      required final String message}) = _$_ApiResponse;

  factory _ApiResponse.fromJson(Map<String, dynamic> json) =
      _$_ApiResponse.fromJson;

  @override
  bool get error;
  @override
  String get message;
  @override
  @JsonKey(ignore: true)
  _$$_ApiResponseCopyWith<_$_ApiResponse> get copyWith =>
      throw _privateConstructorUsedError;
}
