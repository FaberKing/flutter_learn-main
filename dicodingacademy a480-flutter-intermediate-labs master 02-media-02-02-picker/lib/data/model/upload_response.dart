import 'dart:convert';

class UploadResponse {
  final bool error;
  final String message;

  UploadResponse({
    required this.error,
    required this.message,
  });

  factory UploadResponse.fromRawJson(String str) =>
      UploadResponse.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  // factory UploadResponse.fromJson(Map<String, dynamic> json) => UploadResponse(
  //       error: json["error"] ?? false,
  //       message: json["message"] ?? '',
  //     );

  factory UploadResponse.fromMap(Map<String, dynamic> map) {
    return UploadResponse(
      error: map['error'] ?? false,
      message: map['message'] ?? '',
    );
  }

  factory UploadResponse.fromJson(String source) =>
      UploadResponse.fromMap(json.decode(source));

  Map<String, dynamic> toJson() => {
        "error": error,
        "message": message,
      };
}
