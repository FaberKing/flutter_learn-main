import 'dart:convert';
import 'dart:typed_data';

import 'package:flutter_story_app/data/model/stories.dart';
import 'package:flutter_story_app/data/model/story_detail.dart';
import 'package:http/http.dart' as http;

import '../model/api_response.dart';

class ApiServices {
  const ApiServices();
  static const String _baseUrl = "https://story-api.dicoding.dev/v1";
  static var client = http.Client();
  static const String _stories = "/stories";
  static const String _storyDetail = "/stories";

  Future<Stories> getAllStories(String token) async {
    final uri = Uri.parse('$_baseUrl$_stories');

    final response = await client.get(
      uri,
      headers: <String, String>{'Authorization': 'Bearer $token'},
    );

    if (response.statusCode == 200 || response.statusCode == 201) {
      return Stories.fromJson(
        jsonDecode(response.body),
      );
    } else {
      throw Exception("${response.statusCode} ${response.reasonPhrase}");
    }
  }

  Future<StoriesDetail> getStoryDetails(String token, String id) async {
    final response = await client.get(Uri.parse("$_baseUrl$_storyDetail/$id"),
        headers: <String, String>{'Authorization': 'Bearer $token'});
    switch (response.statusCode) {
      case 200:
        return StoriesDetail.fromJson(jsonDecode(response.body));

      default:
        throw Exception("${response.statusCode} ${response.reasonPhrase}");
    }
  }

  Future<ApiResponse> uploadStory(
    List<int> bytes,
    String fileName,
    String description,
    String token,
  ) async {
    final uri = Uri.parse('$_baseUrl$_stories');
    var request = http.MultipartRequest('POST', uri);

    final multiPartFile = http.MultipartFile.fromBytes(
      'photo',
      bytes,
      filename: fileName,
    );

    final Map<String, String> fields = {
      "description": description,
    };
    final Map<String, String> headers = {
      "Content-type": "multipart/form-data",
      "Authorization": 'Bearer $token',
    };

    request.files.add(multiPartFile);
    request.fields.addAll(fields);
    request.headers.addAll(headers);

    final http.StreamedResponse streamedResponse = await request.send();
    final int statusCode = streamedResponse.statusCode;

    final Uint8List responseList = await streamedResponse.stream.toBytes();
    final String responseData = String.fromCharCodes(responseList);

    switch (statusCode) {
      case 201:
      case 200:
        final ApiResponse apiResponse = ApiResponse.fromRawJson(
          responseData,
        );
        return apiResponse;
      default:
        throw Exception(
            "${streamedResponse.statusCode} ${streamedResponse.reasonPhrase}");
    }
  }
}
