import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:flutter/foundation.dart';

part 'api_response.g.dart';
part 'api_response.freezed.dart';

@freezed
class ApiResponse with _$ApiResponse {
  const factory ApiResponse({
    required bool error,
    required String message,
  }) = _ApiResponse;

  factory ApiResponse.fromJson(json) => _$ApiResponseFromJson(json);
}
